use Mojo::Base -strict;

use Test::More tests => 11;

my $package;

BEGIN {
  $package = 'Tekki::Onedrive::Config';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

# methods

can_ok $package, $_
  for qw|access_token delta_link description drive_id drive_type drive_url
  expires_in next_link owner refresh_token save scope validto|;
