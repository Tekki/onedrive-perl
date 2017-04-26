package Tekki::Graph::CalendarDownloader;
use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

use Data::ICal;
use Mojo::File 'path';
use Mojo::JSON 'decode_json';
use Mojo::Util 'encode';
use Tekki::Graph::Event;

# constructor

sub new ($class, $connector) {
  my $self = {connector => $connector};
  return bless $self, $class;
}

# methods

sub synchronize ($self) {
  my $connector = $self->{connector};
  my $config    = $connector->config;

  my $path = $connector->chdir('calendars');

  # list calendars
  $connector->info('List calendars');
  my $response = $connector->get_authorized($config->calendar_url);

  my $calendar_file = $path->child('calendars.json');

  $calendar_file->spurt($response->body);

  for my $calendar ($response->json->{value}->@*) {
    $connector->info("Downloading $calendar->{name}");
    $self->_download_calendar($calendar);
  }

  return $self;
}

# internal methods

sub _download_calendar ($self, $calendar) {
  my $connector = $self->{connector};
  my $config    = $connector->config;

  path($connector->destination, 'calendars', $calendar->{name})
    ->remove_tree({keep_root => 1});
  my $path = $connector->chdir("calendars/$calendar->{name}");

  # download
  my @events;
  my $i;
  my $url = $config->calendar_url . "/$calendar->{id}/events?\$top=1000";
  while ($url) {
    $i++;

    my $response = $connector->get_authorized($url);

    $path->child("events_$i.json")->spurt($response->body);

    my $json  = $response->json;
    my $count = $json->{value}->@*;
    $connector->info("$i: $count events downloaded");

    push @events, $json->{value}->@*;

    $url = $json->{'@odata.nextLink'};
  }

  # export to iCalendar files
  my $prodid = 'Cubulon Graph Backup '. $connector->VERSION;
  my $actual  = Data::ICal->new->add_property(prodid => $prodid);
  my $archive = Data::ICal->new->add_property(prodid => $prodid);

  for (@events) {
    my $event = Tekki::Graph::Event->new($_);
    if ($event->is_actual) {
      $actual->add_entry($event->to_vevent);
    } else {
      $archive->add_entry($event->to_vevent);
    }
  }

  $path->child("$calendar->{name}_actual.ics")
    ->spurt(encode 'UTF-8', $actual->as_string);
  $path->child("$calendar->{name}_archive.ics")
    ->spurt(encode 'UTF-8', $archive->as_string);

  return $self;
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::CalendarDownloader - Downloader for calendars.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
