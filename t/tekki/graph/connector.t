use Mojo::Base -strict;

use Test::More tests => 15;

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
  for qw|authenticate chdir config count_tasks db destination info
    get_authorized logout resync synchronize verbose|;
