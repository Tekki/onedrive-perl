use Mojo::Base -strict;

use open qw|:std :utf8|;
use Test::More tests => 3;

use Mojo::File;
use Mojo::JSON 'decode_json';
use Tekki::Graph::Item;

for my $context (qw|business personal remote|) {
  subtest "Test items $context" => sub {

    # test values

    my %testitem
      = eval Mojo::File::path(__FILE__)->sibling("testitem_$context.pl")->slurp;

    for my $name (sort keys %testitem) {
      ok my $item = Tekki::Graph::Item->new($testitem{$name}{json}),
        "Create item $name";

      my %expected = $testitem{$name}{content}->%*;
      is $item->$_, $expected{$_}, "$_ is $expected{$_}"
        for sort keys %expected;

    }
  };
}
