package Tekki::Graph::Database;
use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Mojo::Date;
use Mojo::File 'path';
use Mojo::JSON 'to_json';
use Mojo::SQLite;

# constants

use constant {
  ITEM_FIELDS => [
    qw|ctag etag file folder lastmodified modifiedby name|,
    qw|package parent_id quickxor remote sha1|,
  ],
};

# constructor

sub new ($class, $destination) {
  my $self = bless {}, $class;

  my $config_path = path($destination, '.config')->make_path;
  my $db = Mojo::SQLite->new("$config_path/onedrive.db");
  $db->migrations->from_file(
    path(__FILE__)->dirname . '/../../../migrations/onedrive.sql')->migrate;

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
    my $item_id = $task->{id};
    if ($task->{file}) {
      $db->delete('task', {item_id => $item_id});
      $db->insert('task', {description => to_json($task), item_id => $item_id});
    } else {
      $db->update(
        'task',
        {description => to_json($task)},
        {item_id     => $item_id}
        )->rows
        or $db->insert('task',
        {description => to_json($task), item_id => $item_id});
    }
    $counter++;
  }

  return $counter;
}

sub count_tasks ($self) {
  my $db = $self->handle;
  return $db->select('task', 'count(*)')->array->[0];
}

sub create_item ($self, $item) {
  my $db = $self->handle;

  my %params = (item_id => $item->id);
  $params{$_} = $item->$_ for $self->ITEM_FIELDS->@*;
  $db->insert('item', \%params);

  return $self;
}

sub delete_item ($self, $item) {
  my $db = $self->handle;
  $self->_delete_recursive($db, $item->{id});
  return $self;
}

sub find_differences ($self, $item) {

  my %actions = ();
  if (my $db_item = $self->find_item($item)) {

    # existing item
    if ($item->deleted) {

      $actions{delete} = {full_path => $db_item->{full_path}};
      $item->name($db_item->{name}) unless $item->name;

    } elsif ($db_item->{full_path} ne $item->full_path) {

      # path and name
      $actions{move} = {
        new_name => $item->name,
        new_path => $item->full_path,
        old_path => $db_item->{full_path},
      };

    } elsif (($item->ctag && $db_item->{ctag} ne $item->ctag)
      || ($item->quickxor && $db_item->{quickxor} ne $item->quickxor))
    {

      # content
      if ($item->folder || $item->package) {
        $actions{update_db} = 1;
      } else {
        $actions{update} = {full_path => $item->full_path};
      }
    }
  } elsif (!$item->deleted && !$item->remote) {

    # new item
    $actions{create} = {name => $item->name, full_path => $item->full_path,};
  }
  return \%actions;
}

sub find_item ($self, $item) {
  my $db = $self->handle;
  my $rv = $db->select('item', undef, {item_id => $item->{id}})->hash or return;

  my @path;
  my $parent = {name => $rv->{name}, parent_id => $rv->{parent_id}};
  while ($parent->{parent_id}) {
    unshift @path, $parent->{name};
    $parent = $db->select(
      'item',
      ['name', 'parent_id'],
      {item_id => $parent->{parent_id}}
    )->hash;
  }
  $rv->{full_path} = @path ? path(@path) : '';

  return $rv;
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
    @since = (timestamp => {'>' => $since});
    $rv->{log_from} = $since;
  } else {
    @since = ();
    $rv->{log_from} = $db->select('log', 'min(timestamp)')->array->[0];
  }

  for my $result (qw|success error ignored|) {
    push $rv->{$result}->@*,
      $db->select('log', undef, {result => $result, @since})->hashes->each;
  }

  for my $result (qw|success error ignored|) {
    $rv->{"${result}count"} = $rv->{$result}->@*;
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
  $params{$_} = $item->$_ for $self->ITEM_FIELDS->@*;
  $db->update('item', \%params, {item_id => $item->{id}});

  return $self;
}

# internal methods

sub _delete_recursive ($self, $db, $item_id) {
  unless ($db->select('item', 'file', {item_id => $item_id})->hash->{file}) {
    $db->select('item', 'item_id', {parent_id => $item_id})
      ->hashes->each(sub { $self->_delete_recursive($db, $_->{item_id}) });
  }
  $db->delete('item', {item_id => $item_id});
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::Database - Stores the details of a destination in SQLite.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
