use Mojo::Base -strict;

use Test::More tests => 1;
use open qw|:std :utf8|;

use Mojo::File;
use Mojo::JSON 'decode_json';
use Tekki::Graph::Event;

for my $context (qw|personal|) {
  subtest "Test events $context" => sub {

    # test values

    my %testevent
      = eval Mojo::File::path(__FILE__)->sibling("testevent_$context.pl")->slurp;

    for my $name (sort keys %testevent) {
      ok my $event = Tekki::Graph::Event->new($testevent{$name}{json}),
        "Create item $name";

      ok my $vevent = $event->to_vevent, 'Convert to vEvent';
      isa_ok $vevent, 'Data::ICal::Entry::Event';

      my @event_string = split /\r\n/, $vevent->as_string;
      my @expected_string = split /\n/, $testevent{$name}{vevent};

      is_deeply \@event_string, \@expected_string, 'convert to iCalendar event';
    }
  };
}
