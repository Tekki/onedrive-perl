package Tekki::Graph::Connector;
use Mojo::Base -base, -signatures;

our $VERSION = '0.91';

use Data::Dump 'pp';
use Digest::SHA 'sha1_hex';
use Mojo::File 'path';
use Mojo::URL;
use Mojo::UserAgent;
use Mojo::Util qw|decode encode|;
use Print::Colored ':all';

use Tekki::Graph::CalendarDownloader;
use Tekki::Graph::Config;
use Tekki::Graph::ContactDownloader;
use Tekki::Graph::Database;
use Tekki::Graph::DriveDownloader;
use Tekki::Graph::Item;

# constants

use constant {
  AUTH_URL     => 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
  BETA_URL     => 'https://graph.microsoft.com/beta',
  CLIENT_ID    => '5a968bc0-ba11-4d28-8837-16f5a8a825aa',
  GRAPH_URL    => 'https://graph.microsoft.com/v1.0',
  REDIRECT_URI => 'https://login.microsoftonline.com/common/oauth2/nativeclient',
  TOKEN_URL    => 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
};

# constructor

sub new ($class, $destination) {
  my $self = bless {}, $class;
  $self->destination($destination);

  return $self;
}

# methods

has ['debug', 'destination', 'verbose'];

sub authenticate ($self) {

  # check destination
  my $path = path($self->destination)->make_path;

  # config
  my $config = Tekki::Graph::Config->new($path);

  # get authorization code
  my $url = Mojo::URL->new(AUTH_URL)->query(
    client_id => CLIENT_ID,
    scope     => 'calendars.read contacts.read files.read files.read.all user.read offline_access',
    response_type => 'code',
    redirect_uri  => REDIRECT_URI,
  );
  say qq|Open the following link in your browser and allow the application to access your drive:|;
  say_info qq|$url\n|;

  my $in   = prompt_input 'Paste the response URL 1: ', -stdio;
  my $code = Mojo::URL->new($in)->query->param('code')
    or die color_error 'URL contains no code';

  # redeem code for access tokens
  my $ua   = Mojo::UserAgent->new;
  my %form = (
    client_id    => CLIENT_ID,
    redirect_uri => REDIRECT_URI,
    code         => $code,
    grant_type   => 'authorization_code',
  );
  my $tx = $ua->post(TOKEN_URL, form => \%form);
  die $self->_error($tx) if $tx->error;
  my $response = $tx->result->json;
  $self->info(color_ok 'Authentication successful.');

  # update config
  $config->$_($response->{$_}) for qw|scope access_token refresh_token|;
  $config->expires_in($response->{expires_in});

  unless ($config->drive_id) {

    # list of available drives
    my @drives;
    my $ua = Mojo::UserAgent->new;

    # my own
    my $tx
      = $ua->get(GRAPH_URL . '/me/drive', {Authorization => "Bearer $response->{access_token}"});
    die $self->_error($tx) if $tx->error;
    my $own        = $tx->result->json;
    my $drive_type = $own->{driveType};
    $own->{description}
      = "$own->{owner}->{user}->{displayName} / Office 365 " . ucfirst $drive_type;

    # ask for SharePoint URL if on business
    my $sharepoint;
    if ($drive_type eq 'business') {
      say 'To backup a SharePoint drive, enter the main URL of the site.';
      $sharepoint = prompt_input 'SharePoint URL []: ';
    }

    if ($sharepoint) {

      # SharePoint

      my ($company, $site) = $sharepoint =~ m|(\w+\.sharepoint\.com)/?(.*)/SitePages/Homepage.aspx|;
      die color_error 'Not a SharePoint URL' unless $company;
      $site = $site ? ":/$site:" : '';

      # name of the site
      $tx = $ua->get(GRAPH_URL . "/sites/$company$site",
        {Authorization => "Bearer $response->{access_token}"});
      die $self->_error($tx) if $tx->error;
      $company =~ /(.*)\.sharepoint\.com/;
      my $sitename = ucfirst($1) . ' / ' . $tx->result->json->{displayName};

      # list drives
      $tx = $ua->get(GRAPH_URL . "/sites/$company$site/drives",
        {Authorization => "Bearer $response->{access_token}"});
      die $self->_error($tx) if $tx->error;

      for my $drive ($tx->result->json->{value}->@*) {
        $drive->{description} = "$sitename $drive->{name}";
        push @drives, $drive;
      }

    } else {

      # OneDrive

      push @drives, $own;

      # shared with me
      $tx = $ua->get(GRAPH_URL . '/me/drive/sharedWithMe',
        {Authorization => "Bearer $response->{access_token}"});

      if ($tx->result) {
        for my $shared ($tx->result->json->{value}->@*) {
          next if $shared->{remoteItem}->{file};

          $shared->{description}
            = "$shared->{remoteItem}->{createdBy}->{user}->{displayName} / $shared->{name}";
          push @drives, $shared;
        }
      }
    }

    # select drive
    my $i;
    say encode 'UTF-8', sprintf("%3d: %s", ++$i, $_->{description}) for @drives;
    $in = prompt_input 'Select drive [1]: ';
    $in ||= 1;
    my $drive = $drives[$in - 1];

    # set config data
    $in = decode 'UTF-8', prompt_input encode 'UTF-8', "Description [$drive->{description}]: ";
    $config->description($in || $drive->{description});
    $config->drive_type($drive_type);
    if (my $remote = $drive->{remoteItem}) {

      # shared folder
      $config->item_id($remote->{id})->drive_id($remote->{parentReference}->{driveId})
        ->drive_url(GRAPH_URL . "/drives/$remote->{parentReference}->{driveId}")
        ->owner($remote->{createdBy}->{user}->{displayName})->remote(1);

    } elsif ($sharepoint) {

      # SharePoint drive
      $config->drive_id($drive->{id})->drive_url(GRAPH_URL . "/drives/$drive->{id}")
        ->owner($drive->{owner}->{user}->{displayName});

    } else {

      # my own drive
      $config->calendar_url(GRAPH_URL . '/me/calendars')->contact_url(GRAPH_URL . '/me/contacts')
        ->drive_id($drive->{id})->drive_url(GRAPH_URL . '/me/drive')
        ->owner($drive->{owner}->{user}->{displayName});

    }

  }
  $config->save;
  $self->info(color_ok 'Config written.');

  return $self;
}

sub chdir ($self, $path) {
  my $new_path = path($self->destination, $path)->make_path;
  chdir $new_path;
  return $new_path;
}

sub config ($self) {
  $self->{config} ||= Tekki::Graph::Config->new($self->destination);
  return $self->{config};
}

sub count_tasks ($self) {
  return $self->db->count_tasks;
}

sub db ($self) {
  $self->{db} ||= Tekki::Graph::Database->new($self->destination);
  return $self->{db};
}

sub get_authorized ($self, $url) {
  my $token = $self->_get_token;
  my $ua    = Mojo::UserAgent->new;
  $ua->max_response_size(0)->max_redirects(10);
  my $rv;
  my $try_again = 5;
  while ($try_again) {
    my $tx = $ua->get($url, {Authorization => "Bearer $token"});
    if (my $err = $tx->error) {
      if (--$try_again && $err->{message} ne 'Gone') {
        my $sleep = 60 / $try_again;
        $self->info("$err->{message}: Waiting $sleep sec before trying again.");
        sleep $sleep;
      } else {
        die $self->_error($tx);
      }
    } else {
      $rv = $tx->result;
      last;
    }
  }
  return $rv;
}

sub info ($self, $message) {
  $self->verbose->($message) if $self->verbose;
  return $self;
}

sub logout ($self) {
  my $config = $self->config;
  $config->$_('') for qw|access_token refresh_token scope validto|;
  $config->save;

  $self->info("Logged out from $config->{description}");

  return $self;
}

sub resync ($self) {
  die 'Cannot resync with pending tasks!' if $self->count_tasks;
  $self->config->delta_link('');
  $self->synchronize({documents_only => 1});
}

sub synchronize ($self, $params = {}) {
  my $config = $self->config;
  die 'Not authenticated' unless $config->refresh_token;

  $self->info($config->description);

  Tekki::Graph::CalendarDownloader->new($self)->synchronize
    if $config->calendar_url
    && !($params->{contacts_only} || $params->{documents_only});
  Tekki::Graph::ContactDownloader->new($self)->synchronize
    if $config->contact_url
    && !($params->{calendars_only} || $params->{documents_only});
  Tekki::Graph::DriveDownloader->new($self)->synchronize
    if $config->drive_url
    && !($params->{calendars_only} || $params->{contacts_only});

  return $self;
}

sub test ($self) {
  my $config = Tekki::Graph::Config->new($self->destination);

  while (1) {
    print "\nURL: ";
    chomp(my $url = <STDIN>);
    last unless $url;

    $url =~ s/<%graph%>/GRAPH_URL/e;
    $url =~ s/<%beta%>/BETA_URL/e;
    $url =~ s/<%(.*?)%>/$config->$1/ge;
    say "$url\n";
    my $ua    = Mojo::UserAgent->new;
    my $token = $self->_get_token;
    my $tx    = $ua->get($url, {Authorization => "Bearer $token"});
    if ($tx->error) {
      warn $self->_error($tx);
      next;
    }
    say pp $tx->result->json;

    if ($self->debug) {
      my $path     = path("$ENV{HOME}/temp")->make_path;
      my $filename = $config->description . '_test_';
      $filename =~ s/\W+/_/g;
      my $i = 1;
      $i++ while -f $path->child("$filename$i.txt");
      $path->child("$filename$i.txt")->spurt($tx->result->body);
    }
  }

  return $self;
}

# internal methods

sub _error ($self, $tx) {
  my $err = $tx->error;
  my $message
    = $err->{code}
    ? "$err->{code} response: $err->{message}"
    : "Connection error: $err->{message}";
  if ($self->verbose) {
    $message .= "\n" . $tx->req->to_string;
    if (my $json = $tx->res->json) {
      $message .= "\n" . pp $json;
    } else {
      $message .= "\n" . $tx->res->body;
    }

  }
  return $message;
}

sub _get_token ($self) {
  my $config = $self->config;
  if ($config->expires_in < 60) {

    my $ua   = Mojo::UserAgent->new;
    my $url  = TOKEN_URL;
    my %form = (
      client_id     => CLIENT_ID,
      redirect_uri  => REDIRECT_URI,
      refresh_token => $config->refresh_token,
      grant_type    => 'refresh_token',
    );
    my $tx = $ua->post($url, form => \%form);
    die $self->_error($tx) if $tx->error;
    my $response = $tx->result->json;
    $config->$_($response->{$_}) for qw|scope access_token refresh_token|;

    $config->expires_in($response->{expires_in})->save;
  }
  return $config->access_token;
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::Connector - The connector itself.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2019, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
