use Mojo::Base -strict;

use Test::More tests => 13;

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
  for qw|authenticate chdir config db destination info get_authorized logout
  synchronize verbose|;
