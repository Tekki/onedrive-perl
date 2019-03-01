package Tekki::Graph::Event;
use Mojo::Base -base, -signatures;

use Data::ICal::Entry::Event;
use Data::ICal::Entry::Alarm::Display;
use Mojo::Util 'decode';

# constructor

sub new ($class, $content) {
  my $self = bless {}, $class;

  $self->content($content);

  return $self;
}

# methods

has 'content';

sub is_actual ($self) {
  my $content = $self->content;
  my $year    = [localtime]->[5] + 1900;
  my $rv      = $content->{end}->{dateTime} gt $year;

  if ($content->{recurrence}) {
    $rv = $content->{recurrence}->{range}->{type} eq 'noEnd'
      || $content->{recurrence}->{range}->{endDate} gt $year;
  }

  return $rv;
}

sub to_vevent ($self) {
  my $content = $self->content;
  my $vevent  = Data::ICal::Entry::Event->new;

  # process content
  my %fields1 = (
    created         => 'createdDateTime',
    description     => 'bodyPreview',
    dtstamp         => 'lastModifiedDateTime',
    'last-modified' => 'lastModifiedDateTime',
    summary         => 'subject',
    uid             => 'iCalUId',
  );
  my %fields2 = (dtend => 'end', dtstart => 'start',);

  my %properties = (priority => 1, sequence => 0,);
  $properties{$_} = $content->{$fields1{$_}} for keys %fields1;

  # attendees
  for my $attendee ($content->{attendees}->@*) {
    my %attributes = (CN => $attendee->{emailAddress}->{name});
    $attributes{RSVP} = 'TRUE'
      if $attendee->{type} && $attendee->{type} eq 'required';
    $vevent->add_property(
      attendee => ["mailto:$attendee->{emailAddress}->{address}", \%attributes]
    );
  }

  # busy status, transparency
  $properties{'x-microsoft-cdo-busystatus'} = uc $content->{showAs};
  $properties{transp}
    = $properties{'x-microsoft-cdo-busystatus'} eq 'FREE'
    ? 'TRANSPARENT'
    : 'OPAQUE';

  # class
  my %class = (
    normal       => 'PUBLIC',
    personal     => 'PRIVATE',
    private      => 'PRIVATE',
    confidential => 'CONFIDENTIAL',
  );
  $properties{class} = $class{$content->{sensitivity}};

  # date/time
  for (qw|dtend dtstart|) {
    my $dt = $content->{$fields2{$_}};
    if ($content->{isAllDay}) {
      $dt->{dateTime} =~ s/-//g;
      $dt->{dateTime} =~ s/T.*//;
      $properties{$_} = [$dt->{dateTime}, {VALUE => 'DATE'}];
    } else {
      $properties{$_} = $dt->{dateTime};
    }
  }
  for (qw|created dtend dtstamp dtstart last-modified|) {
    $properties{$_} =~ s/-|://g;
    $properties{$_} =~ s/\.\d+Z?/Z/;
  }

  # importance
  my %importance = (low => 0, normal => 1, high => 2,);
  $properties{'x-microsoft-cdo-importance'}
    = $importance{$content->{importance}};

  # location
  $properties{location} = $content->{location}->{displayName};

  # organizer
  my $email = $content->{organizer}->{emailAddress};
  # in some cases the name is encoded twice
  my $name = decode('UTF-8', $email->{name}) || $email->{name};
  $properties{organizer} = ["mailto:$email->{address}", {CN => $name}];

  # recurrence
  if ($content->{recurrence}) {
    my $pattern = $content->{recurrence}->{pattern};
    my $range   = $content->{recurrence}->{range};
    $properties{rrule} = uc "FREQ=$pattern->{type}";
    $properties{rrule} =~ s/ABSOLUTE|RELATIVE//;
    $properties{rrule} .= ";INTERVAL=$pattern->{interval}"
      if $pattern->{interval} != 1;
    $properties{rrule} .= ";COUNT=$range->{numberOfOccurrences}"
      if $range->{numberOfOccurrences};
    $properties{rrule} .= uc ";BYDAY=" . join ',',
      map { substr $_, 0, 2 } $pattern->{daysOfWeek}->@*
      if $pattern->{daysOfWeek} && $pattern->{daysOfWeek}->@*;
    $properties{rrule} .= ";BYMONTHDAY=$pattern->{dayOfMonth}"
      if $pattern->{dayOfMonth};
    $properties{rrule} .= ";BYMONTH=$pattern->{month}" if $pattern->{month};

  }

  # reminder
  if ($content->{isReminderOn}) {
    my $valarm = Data::ICal::Entry::Alarm::Display->new;
    $valarm->add_properties(
      description => 'Reminder',
      trigger     => "-PT$content->{reminderMinutesBeforeStart}M",
    );
    $vevent->add_entry($valarm);
  }

  # delete empty
  for (qw|location recurrence-id rrule status url|) {
    delete $properties{$_} unless $properties{$_}
  }

  $vevent->add_properties(%properties);

  return $vevent;
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::Event - An event in a calendar.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2019, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
