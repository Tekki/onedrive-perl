package Tekki::Graph::Config;

use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Mojo::Date;
use Mojo::File 'path';
use Mojo::Util qw|decode encode|;

# constants

use constant {
  CONFIG_FILE => 'onedrive.conf',
  CONFIG_VARS => [
    qw|calendar_url contact_url description drive_id drive_type
      drive_url item_id owner remote|
  ],
  TOKEN_FILE => 'token.conf',
  TOKEN_VARS => [
    qw|access_token refresh_token scope validto
      next_link delta_link|
  ],
};

# constructor

sub new ($class, $destination) {
  my $self = {};
  bless $self, $class;

  my $config_path = path($destination, '.config')->make_path;


  # config file
  my $configfile = $config_path->child(CONFIG_FILE);
  $self->{configfile} = $configfile;
  if (-f $configfile) {
    my %config = map { split /=/, $_, 2 } split /\r?\n/,
      decode('UTF-8', $configfile->slurp);
    $self->$_($config{$_} || '') for CONFIG_VARS->@*;
  }

  # token file
  my $tokenfile = $config_path->child(TOKEN_FILE);
  $self->{tokenfile} = $tokenfile;
  if (-f $tokenfile) {
    my %config = map { split /=/, $_, 2 } split /\r?\n/,
      decode('UTF-8', $tokenfile->slurp);
    $self->$_($config{$_} || '') for TOKEN_VARS->@*;
  }

  return $self;
}

# methods

has [
  qw|access_token calendar_url contact_url description drive_id
    drive_type drive_url item_id owner refresh_token remote scope validto|
];

sub delta_link ($self, $newvalue = undef) {
  if (defined $newvalue) {
    delete $self->{next_link};
    $self->{delta_link} = $newvalue;
    return $self;
  } else {
    my $rv;
    if ($self->{next_link}) {
      $rv = '';
    } elsif ($self->{delta_link}) {
      $rv = $self->{delta_link};
    } elsif ($self->remote) {
      $rv = $self->drive_url . '/items/' . $self->item_id . '/delta';
    } else {
      $rv = $self->drive_url . '/root/delta';
    }
    return $rv;
  }
}

sub expires_in ($self, $seconds = undef) {
  if (defined $seconds) {
    $self->validto(Mojo::Date->new(time + $seconds)->to_datetime);
    return $self;
  } else {
    return Mojo::Date->new($self->validto)->epoch - time;
  }
}

sub next_link ($self, $newvalue = undef) {
  if (defined $newvalue) {
    delete $self->{delta_link};
    $self->{next_link} = $newvalue;
    return $self;
  } else {
    return $self->{next_link};
  }
}

sub save ($self) {
  unless (-f $self->{configfile}) {
    # don't touch an existing config file
    $self->{configfile}->spurt(encode 'UTF-8',
      join "\n", map { "$_=" . ($self->$_ || '') } CONFIG_VARS->@*);
  }

  $self->{tokenfile}->spurt(encode 'UTF-8',
    join "\n", map { "$_=" . ($self->$_ || '') } TOKEN_VARS->@*);

  return $self;
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::Config - The configuration of a specific destination.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
