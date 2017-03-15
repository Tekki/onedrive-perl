package Tekki::Onedrive::Database;
use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Mojo::Date;
use Mojo::File 'path';
use Mojo::JSON 'to_json';
use Mojo::SQLite;

# constants

use constant {
  FIELDS => [
    qw|ctag etag lastmodified name parent_id parent_path|,
    qw|modifiedby sha1 file folder package|,
  ],
};

# constructor

sub new ($class, $destination) {
  my $self = bless {}, $class;

  my $config_path = Mojo::File::path($destination, 'config')->make_path;
  my $db = Mojo::SQLite->new("$config_path/onedrive.db");
  $db->migrations->from_file(
    path(__FILE__)->dirname . '/../../../migrations/onedrive.sql')
    ->migrate;

  $self->{db} = $db;
  $self->handle($db->db);

  return $self;
}

# methods

has 'handle';

sub add_tasks ($self, $tasklist) {
  my $counter = 0;
  my $db      = $self->handle;
  for my $task ($tasklist->@*) {
    $db->insert('task', {description => to_json $task});
    $counter++;
  }

  return $counter;
}

sub create_item ($self, $item) {

  my $db = $self->handle;

  my %params = (item_id => $item->id);
  $params{$_} = $item->$_ for $self->FIELDS->@*;
  $db->insert('item', \%params);

  return $self;
}

sub delete_item ($self, $item) {
  my $db = $self->handle;
  $db->delete('item', {item_id => $item->{id}});
  return $self;
}

sub find_differences ($self, $item) {

  my %actions = ();
  if (my $db_item = $self->find_item($item)) {

    # existing item
    if ($item->deleted) {
      $actions{delete} = {full_path => $item->full_path};
    } else {

      # path and name
      if ( $db_item->{name} ne $item->name
        || $db_item->{parent_path} ne $item->parent_path)
      {
        $actions{move} = {
          new_name        => $item->name,
          new_parent_path => $item->parent_path,
          new_path        => $item->full_path,
          old_path =>
            Mojo::File::path($db_item->{parent_path}, $db_item->{name}),
          }
      }

      # content
      if ($db_item->{ctag} ne $item->ctag) {

        if ($item->folder || $item->package) {
          $actions{update_db} = 1;
        } else {
          $actions{update} = {full_path => $item->full_path};
        }

      }

    }
  } elsif (!$item->deleted) {

    # new item
    $actions{create} = {
      name        => $item->name,
      parent_path => $item->parent_path,
      full_path   => $item->full_path,
    };
  }
  return \%actions;
}

sub find_item ($self, $item) {
  my $db = $self->handle;
  return $db->select('item', '*', {item_id => $item->{id}})->hash;
}

sub log ($self, $since) {

  my $db = $self->handle;
  my $rv = {
    success => [],
    error   => [],
    ignored => [],
    log_to  => Mojo::Date->new->to_datetime,
  };
  my @since;
  if ($since) {
    @since =  (timestamp => {'>' => $since});
    $rv->{log_from} = $since;
  } else {
    @since = ();
    $rv->{log_from} = $db->select('log', 'min(timestamp)')->array->[0];
  }

  for my $result (qw|success error ignored|) {
    push $rv->{$result}->@*,
      $db->select('log', '*', {result => $result, @since})->hashes->each;
  }

  for my $result (qw|success error ignored|) {
    $rv->{"${result}count"} =  $rv->{$result}->@*;
  }

  return $rv;
}

sub next_task ($self) {
  my $db = $self->handle;
  return $db->query('SELECT * FROM task LIMIT 1')
    ->expand(json => 'description')->hash;
}

sub task_failed ($self, $task, $item, $action) {
  my $db = $self->handle;
  $db->insert(
    'log',
    {
      timestamp    => Mojo::Date->new->to_datetime,
      item_id      => $item->id,
      name         => $item->name,
      lastmodified => $item->lastmodified,
      modifiedby   => $item->modifiedby,
      action       => $action,
      result       => 'error',
    }
  );
  $db->query('UPDATE task SET failures = failures + 1 WHERE id = ?',
    $task->{id});
  return $self;
}

sub task_ignored ($self, $task, $item) {
  my $db = $self->handle;
  $db->insert(
    'log',
    {
      timestamp    => Mojo::Date->new->to_datetime,
      item_id      => $item->id,
      name         => $item->name,
      lastmodified => $item->lastmodified,
      modifiedby   => $item->modifiedby,
      result       => 'ignored',
    }
  );
  $db->delete('task', {id => $task->{id}});
  return $self;
}

sub task_succeeded ($self, $task, $item, $action) {
  my $db = $self->handle;
  $db->insert(
    'log',
    {
      timestamp    => Mojo::Date->new->to_datetime,
      item_id      => $item->id,
      name         => $item->name,
      lastmodified => $item->lastmodified,
      modifiedby   => $item->modifiedby,
      action       => $action,
      result       => 'success',
    }
  );
  $db->delete('task', {id => $task->{id}});
  return $self;
}

sub update_item ($self, $item) {

  my $db = $self->handle;


  my %params = ();
  $params{$_} = $item->$_ for $self->FIELDS->@*;
  $db->update('item', \%params, {item_id => $item->{id}});

  return $self;
}

1;

=encoding utf8

=head1 NAME

Tekki::Onedrive::Database - Stores the details of a destination in SQLite.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
