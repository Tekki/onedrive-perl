package Tekki::Onedrive::Config;

use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Mojo::Date;
use Mojo::File 'path';
use Mojo::Util qw|decode encode|;

# constants

use constant {
  CONFIG_VARS => [
    qw|access_token description drive_id drive_type drive_url
      item_id owner refresh_token remote scope validto
      next_link delta_link|
  ],
};

# constructor

sub new ($class, $destination) {
  my $self = {};
  bless $self, $class;

  my $config_path = path($destination, 'config')->make_path;
  my $configfile = $config_path->child('onedrive.conf');
  $self->configfile($configfile);

  if (-f $configfile) {
    my %config = map { split /=/, $_, 2 } split /\r?\n/,
      decode('UTF-8', $configfile->slurp);
    $self->$_($config{$_} || '') for CONFIG_VARS->@*;
  }

  return $self;
}

# methods

has [
  qw|access_token configfile description drive_id drive_type drive_url
    item_id owner refresh_token remote scope validto|
];

sub delta_link ($self, $newvalue = undef) {
  if (defined $newvalue) {
    delete $self->{next_link};
    $self->{delta_link} = $newvalue;
    return $self->save;
  } else {
    my $rv;
    if ($self->{next_link}) {
      $rv = '';
    } elsif (exists $self->{delta_link}) {
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
    return $self->save;
  } else {
    return $self->{next_link};
  }
}

sub save ($self) {
  $self->configfile->spurt(
    encode 'UTF-8', join "\n",
    map { "$_=" . ($self->$_ || '') } CONFIG_VARS->@*
  );
  return $self;
}

1;

=encoding utf8

=head1 NAME

Tekki::Onedrive::Config - The configuration of a specific destination.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
