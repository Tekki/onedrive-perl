use Mojo::Base -strict;

use Test::More tests => 2;

use Mojo::File;
use Mojo::JSON 'decode_json';
use Tekki::Onedrive::Item;

for my $context (qw|personal remote|) {
  subtest "Test items $context" => sub {

    # test values

    my %testitem
      = eval Mojo::File::path(__FILE__)->sibling("testitem_$context.pl")->slurp;

    for my $name (sort keys %testitem) {
      ok my $item = Tekki::Onedrive::Item->new($testitem{$name}{json}),
        "Create item $name";

      my %expected = $testitem{$name}{content}->%*;
      is $item->$_, $expected{$_}, "$_ is $expected{$_}"
        for sort keys %expected;

    }
  };
}
