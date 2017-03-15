package Tekki::Onedrive::Config;

use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Config::Tiny;
use Mojo::Date;
use Mojo::File 'path';

# constructor

sub new ($class, $destination) {

  my $self = bless {}, $class;

  my $config_path = path($destination, 'config')->make_path;
  my $configfile = "$config_path/onedrive.conf";
  $self->configfile($configfile);

  if (-f $configfile) {
    $self->content(Config::Tiny->read($configfile));
  } else {
    $self->content(Config::Tiny->read_string(q|description=|));
  }

  return $self;
}

# methods

has ['configfile', 'content'];

sub delta_link ($self, $newvalue = undef) {
  if (defined $newvalue) {
    delete $self->content->{_}->{next_link};
    $self->value('delta_link', $newvalue)->save;
    return $self;
  } else {
    return $self->value('delta_link')
      || $self->value('drive_url') . '/root/delta';
  }
}

sub expires_in ($self, $seconds = undef) {
  if (defined $seconds) {
    $self->value(validto => Mojo::Date->new(time + $seconds)->to_datetime);
    return $self;
  } else {
    return Mojo::Date->new($self->value('validto'))->epoch - time;
  }
}

sub next_link ($self, $newvalue = undef) {
  if (defined $newvalue) {
    delete $self->content->{_}->{delta_link};
    $self->value('next_link', $newvalue)->save;
    return $self;
  } else {
    return $self->value('next_link');
  }
}

sub save ($self) {
  $self->content->write($self->configfile);
  return $self;
}

sub value ($self, $key, $value = undef) {
  if (defined $value) {
    $self->content->{_}->{$key} = $value;
    return $self;
  } else {
    return $self->content->{_}->{$key};
  }
}

sub values ($self) {
  return $self->content->{_};
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
