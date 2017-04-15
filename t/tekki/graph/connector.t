use Mojo::Base -strict;

use Test::More tests => 8;

my $package;

BEGIN {
  $package = 'Tekki::Graph::Connector';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

# methods

can_ok $package, $_
  for qw|authenticate destination logout synchronize verbose|;
  ;
