package Tekki::Onedrive::Item;
use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Digest::SHA 'sha1_hex';
use Mojo::Date;
use Mojo::File;
use Mojo::Util qw|decode url_unescape|;

# constructor

sub new ($class, $content) {
  my $self = bless {}, $class;

  $self->update($content);

  return $self;
}

# methods

has [qw|id ctag etag lastmodified name|];
has [qw|modifiedby package parent_id parent_path quickxor sha1|] => '';
has [qw|deleted file folder remote root size|] => 0;

sub exists ($self) {
  if ($self->file) {
    return -f $self->full_path || 0;
  } else {
    return -d $self->full_path || 0;
  }
}

sub exists_identical ($self) {
  if ($self->file) {
    return $self->exists
      && sha1_hex($self->full_path->slurp) eq $self->sha1 ? 1 : 0;
  } else {
    return $self->exists;
  }
}

sub full_path ($self) {
  my @path = ($self->name);
  unshift @path, $self->parent_path if $self->parent_path;
  return Mojo::File::path(@path);
}

sub mtime ($self) {
  return $self->exists
    ? Mojo::Date->new((stat $self->full_path)[9])->to_datetime
    : '';
}

sub update ($self, $content) {

  # process content
  for (qw|id name|) {
      $self->$_($content->{$_}) if $content->{$_}; 
  }

  $self->lastmodified($content->{lastModifiedDateTime});
  $self->modifiedby($content->{lastModifiedBy}->{user}->{displayName})
    if $content->{lastModifiedBy};

  if ($content->{remoteItem}) {
    $self->$_($content->{remoteItem}->{$_} ? 1 : 0) for qw|file folder package|;
    $self->size($content->{remoteItem}->{size} || 0);
    $self->remote(1);
  } else {
    $self->$_($content->{$_} ? 1 : 0) for qw|file folder package|;
    $self->size($content->{size} || 0);
  }

  $self->ctag($content->{cTag} || '');
  $self->etag($content->{eTag} || '');
  if ($content->{deleted}) {
    $self->deleted(1);
  } elsif (my $file = $content->{file}) {
    if (my $hashes = $file->{hashes}) {
      $self->sha1(lc $hashes->{sha1Hash}) if $hashes->{sha1Hash};
      $self->quickxor($hashes->{quickXorHash}) if $hashes->{quickXorHash};
    } else {
      $self->deleted(1);
    }
  }

  # parent
  if (my $parent = $content->{parentReference} and !$content->{root}) {
    $self->parent_id($parent->{id});
    my $parent_path = $parent->{path} || '';

    # personal only
    $parent_path = decode 'UTF-8', url_unescape $parent_path if $parent->{name};

    $parent_path =~ s|.*?:/?||;
    $self->parent_path($parent_path);
  } else {
    $self->root(1);
  }

  return $self;
}

sub update_mtime ($self) {
  if ($self->exists) {
    utime time, Mojo::Date->new($self->lastmodified)->epoch, $self->full_path;
  }
  return $self;
}

1;

=encoding utf8

=head1 NAME

Tekki::Onedrive::Item - An item on OneDrive.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
