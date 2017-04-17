package Tekki::Graph::DriveDownloader;
use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Mojo::File 'path';
use Mojo::Util 'encode';

# constructor

sub new ($class, $connector) {
  my $self = {connector => $connector};
  return bless $self, $class;
}

# methods

sub synchronize ($self) {
  my $connector = $self->{connector};
  my $config    = $connector->config;
  my $db        = $connector->db;

  $connector->chdir('documents');
  $connector->info('Downloading documents');

  my $continue      = 1;
  my $download_more = 1;
  while ($continue) {

    # check for existing tasks
    while (my $task = $db->next_task) {
      my $item = Tekki::Graph::Item->new($task->{description});

      $connector->info("$task->{id}: " . $item->name);

      my $actions = $db->find_differences($item);
      unless (keys $actions->%*) {

        # ignore task without action
        $db->task_ignored($task, $item);
        $connector->info('  ignored');
        next;
      }

      # create new item
      if (my $create = $actions->{create}) {
        unless ($item->root) {
          if ($item->{file}) {

            # download content
            $self->_download_content($item, $create->{full_path});

          } elsif ($item->{folder} || $item->{package}) {

            # create folder
            $create->{full_path}->make_path;
            $connector->info('  folder created');

          } else {

            # unknown type
            die "Unknown file type in task $task->{id}";
          }

          # change modification time
          $item->update_mtime;
        }
        $db->create_item($item);
        $db->task_succeeded($task, $item, 'create');
        $connector->info('  db updated');
      }

      # move or rename
      if (my $move = $actions->{move}) {
        unless ($item->{root}) {

          # move local file
          $move->{old_path}->move_to($move->{new_path});
          $connector->info("  moved to $move->{new_path}");

          # change modification time
          $item->update_mtime;

        }
        $db->update_item($item);
        $db->task_succeeded($task, $item, 'move');
        $connector->info('  db updated');
      }

      # update
      if (my $update = $actions->{update}) {
        $self->_download_content($item, $update->{full_path});
        $item->update_mtime;

        $db->update_item($item);
        $db->task_succeeded($task, $item, 'update');
        $connector->info('  db updated');
      }

      # update db
      if ($actions->{update_db}) {
        $db->update_item($item);

        $db->task_ignored($task, $item);
        $connector->info('  db updated');
      }

      # delete
      if (my $delete = $actions->{delete}) {
        $delete->{full_path}->remove_tree;
        $connector->info('  deleted');

        $db->delete_item($item);
        $db->task_succeeded($task, $item, 'delete');
        $connector->info('  db updated');
      }

    }
    $continue = 0;

    # download new instructions
    if ($download_more) {
      my $delta_url = $config->next_link || $config->delta_link;

      my $response = $connector->get_authorized($delta_url);
      my $json     = $response->json;

      # update next or delta link
      if ($json->{'@odata.nextLink'}) {
        $config->next_link($json->{'@odata.nextLink'});
      } else {
        $config->delta_link($json->{'@odata.deltaLink'});
        $download_more = 0;
      }

      # debug
      if ($connector->debug) {
        my $path     = path("$ENV{HOME}/temp")->make_path;
        my $filename = $config->description . '_delta_';
        $filename =~ s/\W+/_/g;
        my $i = 1;
        $i++ while -f $path->child("$filename$i.txt");
        $path->child("$filename$i.txt")->spurt($response->body);
      }

      # add to db
      my $counter = $db->add_tasks($json->{value});
      $connector->info("\n$counter new tasks downloaded\n");
      $continue = $counter ? 1 : 0;
    }
  }

  return $self;
}

# internal methods

sub _download_content ($self, $item, $path) {
  my $connector = $self->{connector};
  my $config    = $connector->config;

  if ($item->exists_identical) {
    $connector->info('  download skipped');
    return;
  }

  # update metadata
  my $url = $config->drive_url . "/items/$item->{id}";

  my $json   = $connector->get_authorized($url)->json;
  my $hashes = $json->{file}->{hashes};
  $item->sha1(lc $hashes->{sha1Hash}) if $hashes->{sha1Hash};

  # download
  $url = $json->{'@microsoft.graph.downloadUrl'};

# size is unreliable!
#  my $asset_size = $tx->success->content->asset->size;
#  die "Size of $item->{name} is $asset_size instead of $item->{size}!"
#    if $asset_size != $item->size;

  $connector->get_authorized($url)->content->asset->move_to($path);

  if ($config->drive_type eq 'personal') {

    # not yet working on business
    die encode 'UTF-8', "Download of $item->{name} failed!"
      unless $item->exists_identical;
  }

  $connector->info('  content downloaded');
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::DriveDownloader - Downloader for drive items.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
