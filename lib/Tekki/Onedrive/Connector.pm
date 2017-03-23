package Tekki::Onedrive::Connector;

use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

our $VERSION = 0.60;

use Data::Dump 'pp';
use Digest::SHA 'sha1_hex';
use Config::Tiny;
use Mojo::File 'path';
use Mojo::URL;
use Mojo::UserAgent;
use Mojo::Util qw|decode encode|;

use Tekki::Onedrive::Config;
use Tekki::Onedrive::Database;
use Tekki::Onedrive::GlobalConfig;
use Tekki::Onedrive::Item;

# constants

use constant {WAIT_FOR_RETRY => 10, MAX_RETRIES => 5,};

# constructor

sub new ($class, $destination) {
  my $self = bless {}, $class;
  $self->destination($destination);

  return $self;
}

# methods

has ['debug', 'destination', 'verbose'];

sub authenticate ($self) {

  # globals
  my $globals = Tekki::Onedrive::GlobalConfig->new;

  # check destination
  my $path = path($self->destination)->make_path;
  $path->child($_)->make_path for qw|config documents|;

  # config
  my $config = Tekki::Onedrive::Config->new($path);

  # get authorization code
  my $url = Mojo::URL->new($globals->value('auth_url'))->query(
    client_id     => $globals->value('client_id'),
    scope         => "user.read files.read files.read.all offline_access",
    response_type => 'code',
    redirect_uri  => $globals->value('redirect_uri'),
  );
  say
    qq|Open the following link in your browser and allow the application to access your drive:\n$url\n|;

  print 'Paste the response URL: ';
  chomp(my $in = <STDIN>);
  my $code = Mojo::URL->new($in)->query->param('code')
    or die 'URL contains no code';

  # redeem code for access tokens
  my $ua   = Mojo::UserAgent->new;
  my %form = (
    client_id    => $globals->value('client_id'),
    redirect_uri => $globals->value('redirect_uri'),
    code         => $code,
    grant_type   => 'authorization_code',
  );
  my $tx = $ua->post($globals->value('token_url'), form => \%form);
  die $self->_error($tx) if $tx->error;
  my $response = $tx->success->json;
  say 'Authentication successful.' if $self->verbose;

  # update config
  $config->$_($response->{$_}) for qw|scope access_token refresh_token|;
  $config->expires_in($response->{expires_in});

  unless ($config->drive_id) {

    # list of available drives
    my @drives;
    my $ua = Mojo::UserAgent->new;

    # my own
    my $tx = $ua->get(
      $globals->value('drive_url') . '/me/drive',
      {Authorization => "Bearer $response->{access_token}"}
    );
    die $self->_error($tx) if $tx->error;
    my $own        = $tx->success->json;
    my $drive_type = $own->{driveType};
    $own->{description} = "$own->{owner}->{user}->{displayName} / OneDrive "
      . ucfirst $drive_type;
    push @drives, $own;

    # shared with me
    $tx = $ua->get(
      $globals->value('drive_url') . '/me/drive/sharedWithMe',
      {Authorization => "Bearer $response->{access_token}"}
    );
    die $self->_error($tx) if $tx->error;

    for my $shared ($tx->success->json->{value}->@*) {
      next if $shared->{remoteItem}->{file};

      $shared->{description}
        = "$shared->{remoteItem}->{createdBy}->{user}->{displayName} / $shared->{name}";
      push @drives, $shared;
    }

    # select drive
    my $i;
    say encode 'UTF-8', sprintf("%3d: %s", ++$i, $_->{description}) for @drives;
    print 'Select drive [1]: ';
    chomp($in = <STDIN>);
    $in ||= 1;
    my $drive = $drives[$in - 1];

    # set config data
    print encode 'UTF-8', "Description [$drive->{description}]: ";
    chomp($in = <STDIN>);
    $in = decode 'UTF-8', $in;
    $config->description($in || $drive->{description});
    $config->drive_type($drive_type);
    if (my $remote = $drive->{remoteItem}) {

      # shared folder
      $config->item_id($remote->{id});
      $config->drive_id($remote->{parentReference}->{driveId});
      $config->drive_url($globals->value('drive_url')
          . "/drives/$remote->{parentReference}->{driveId}");
      $config->owner($remote->{createdBy}->{user}->{displayName});
      $config->remote(1);

    } else {

      # my own drive
      $config->drive_id($drive->{id});
      $config->drive_url($globals->value('drive_url') . '/me/drive');
      $config->owner($drive->{owner}->{user}->{displayName});

    }

  }
  $config->save;
  say 'Config written.' if $self->verbose;

  return $self;
}

sub logout ($self) {
  my $config = Tekki::Onedrive::Config->new($self->destination);
  $config->$_('') for qw|access_token refresh_token scope validto|;
  $config->save;

  return $self;
}

sub synchronize ($self) {
  my $config = Tekki::Onedrive::Config->new($self->destination);
  die 'Not authenticated' unless $config->refresh_token;

  say encode 'UTF-8', $config->description if $self->verbose;

  my $db = Tekki::Onedrive::Database->new($self->destination);

  chdir $self->destination . '/documents';

  my $continue      = 1;
  my $download_more = 1;
  while ($continue) {

    # check for existing tasks
    while (my $task = $db->next_task) {
      my $item = Tekki::Onedrive::Item->new($task->{description});

      say encode 'UTF-8', "$task->{id}: $item->{name}" if $self->verbose;

      my $actions = $db->find_differences($item);
      unless (keys $actions->%*) {

        # ignore task without action
        $db->task_ignored($task, $item);
        say '  ignored' if $self->verbose;
        next;
      }

      # create new item
      if (my $create = $actions->{create}) {
        unless ($item->root) {
          if ($item->{file}) {

            # download content
            $self->_download_content($item, $create->{full_path}, $config);

          } elsif ($item->{folder} || $item->{package}) {

            # create folder
            $create->{full_path}->make_path;
            say '  folder created' if $self->verbose;

          } else {

            # unknown type
            die "Unknown file type in task $task->{id}";
          }

          # change modification time
          $item->update_mtime;
        }
        $db->create_item($item);
        $db->task_succeeded($task, $item, 'create');
        say '  db updated' if $self->verbose;
      }

      # move or rename
      if (my $move = $actions->{move}) {
        unless ($item->{root}) {

          # move local file
          $move->{old_path}->move_to($move->{new_path});
          say encode 'UTF-8', "  moved to $move->{new_path}" if $self->verbose;

          # change modification time
          $item->update_mtime;

        }
        $db->update_item($item);
        $db->task_succeeded($task, $item, 'move');
        say '  db updated' if $self->verbose;
      }

      # update
      if (my $update = $actions->{update}) {
        $self->_download_content($item, $update->{full_path}, $config);
        $item->update_mtime;

        $db->update_item($item);
        $db->task_succeeded($task, $item, 'update');
        say '  db updated' if $self->verbose;
      }

      # update db
      if ($actions->{update_db}) {
        $db->update_item($item);

        $db->task_ignored($task, $item);
        say '  db updated' if $self->verbose;
      }

      # delete
      if (my $delete = $actions->{delete}) {
        unlink $delete->{full_path};
        say '  deleted' if $self->verbose;

        $db->delete_item($item);
        $db->task_succeeded($task, $item, 'delete');
        say '  db updated' if $self->verbose;
      }

    }
    $continue = 0;

    # download new instructions
    if ($download_more) {
      my $delta_url = $config->next_link || $config->delta_link;
      my $token     = $self->_get_token($config);
      my $ua        = Mojo::UserAgent->new;
      my $tx        = $ua->get($delta_url, {Authorization => "Bearer $token"});
      die $self->_error($tx) if $tx->error;

      my $response = $tx->success->json;

      # debug
      if ($self->debug) {
        my $path     = path("$ENV{HOME}/temp")->make_path;
        my $filename = $config->description . '_delta_';
        my $i        = 1;
        $i++ while -f $path->child("$filename$i.txt");
        $path->child("$filename$i.txt")->spurt($tx->success->body);
      }

      # add to db
      my $counter = $db->add_tasks($response->{value});
      say "\n$counter new tasks downloaded\n" if $self->verbose;
      $continue = $counter ? 1 : 0;

      # download more instructions or not
      if ($response->{'@odata.nextLink'}) {
        $config->next_link($response->{'@odata.nextLink'});
      } else {
        $config->delta_link($response->{'@odata.deltaLink'});
        $download_more = 0;
      }
    }
  }
}

sub test ($self) {
  my $config = Tekki::Onedrive::Config->new($self->destination);
  my $token  = $self->_get_token($config);

  while (1) {
    print 'URL: ';
    chomp(my $url = <STDIN>);
    last unless $url;

    $url =~ s/<%(.*?)%>/$config->$1/ge;
    my $ua = Mojo::UserAgent->new;
    my $tx = $ua->get($url, {Authorization => "Bearer $token"});
    if ($tx->error) {
      warn $self->_error($tx);
      next;
    }
    say pp $tx->success->json;

    if ($self->debug) {
      my $path     = path("$ENV{HOME}/temp")->make_path;
      my $filename = $config->description . '_test_';
      my $i        = 1;
      $i++ while -f $path->child("$filename$i.txt");
      $path->child("$filename$i.txt")->spurt($tx->success->body);
    }
  }
}

# internal methods

sub _download_content ($self, $item, $path, $config) {
  if ($item->exists_identical) {
    say '  download skipped' if $self->verbose;
    return;
  }

  # update metadata
  my $ua    = Mojo::UserAgent->new;
  my $token = $self->_get_token($config);

  my $url = $config->drive_url . "/items/$item->{id}";
  my $tx = $ua->get($url, {Authorization => "Bearer $token"});
  die $self->_error($tx) if $tx->error;

  my $json = $tx->success->json;
  $item->update($json);

  # download
  $url = $json->{'@microsoft.graph.downloadUrl'};
  $tx = $ua->get($url, {Authorization => "Bearer $token"});
  die $self->_error($tx) if $tx->error;

# size is unreliable!
#  my $asset_size = $tx->success->content->asset->size;
#  die "Size of $item->{name} is $asset_size instead of $item->{size}!"
#    if $asset_size != $item->size;

  $tx->success->content->asset->move_to($path);

  die encode 'UTF-8', "Download of $item->{name} failed!"
    unless $item->exists_identical;

  say '  content downloaded' if $self->verbose;
}

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

sub _get_token ($self, $config) {
  if ($config->expires_in < 60) {
    my $globals = Tekki::Onedrive::GlobalConfig->new;

    my $ua   = Mojo::UserAgent->new;
    my $url  = $globals->value('token_url');
    my %form = (
      client_id     => $globals->value('client_id'),
      redirect_uri  => $globals->value('redirect_uri'),
      refresh_token => $config->refresh_token,
      grant_type    => 'refresh_token',
    );
    my $tx = $ua->post($url, form => \%form);
    die $self->_error($tx) if $tx->error;
    my $response = $tx->success->json;
    $config->$_($response->{$_}) for qw|scope access_token refresh_token|;

    $config->expires_in($response->{expires_in})->save;
  }
  return $config->access_token;
}

1;

=encoding utf8

=head1 NAME

Tekki::Onedrive::Connector - The connector itself.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
