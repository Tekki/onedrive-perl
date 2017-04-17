use strict;
use warnings;

use Test::More tests => 4;

my $package;

BEGIN {
  $package = 'Tekki::Graph::ContactDownloader';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

# methods

can_ok $package, $_ for qw|synchronize|;
