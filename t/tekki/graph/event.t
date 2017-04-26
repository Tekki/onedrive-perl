use strict;
use warnings;

use Test::More tests => 4;

my $package;

BEGIN {
  $package = 'Tekki::Graph::Event';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

# methods

subtest 'Methods' => sub {
  can_ok $package, $_ for qw|content is_actual to_vevent|;
};
