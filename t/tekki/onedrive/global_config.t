use Mojo::Base -strict;

use Test::More tests => 9;

my $package;

BEGIN {
  $package = 'Tekki::Onedrive::GlobalConfig';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

# methods

can_ok $package, $_ for qw|content context value|;

# default config

ok my $globals = $package->new, 'Create global config';

is $globals->context, 'Microsoft Graph', 'Context is Graph';

my %expected = (
  auth_url  => 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
  client_id => '5a968bc0-ba11-4d28-8837-16f5a8a825aa',
  drive_url => 'https://graph.microsoft.com/v1.0',
  redirect_uri =>
    'https://login.microsoftonline.com/common/oauth2/nativeclient',
  token_url => 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
);

subtest 'Config Values' => sub {
  is $globals->value($_), $expected{$_}, "$_ is $expected{$_}"
    for sort keys %expected;
};
