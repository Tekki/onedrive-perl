use Mojo::Base -strict;

use open qw|:std :utf8|;
use Test::More tests => 45;

use Mojo::Date;
use Mojo::File;

my $package;

BEGIN {
  $package = 'Tekki::Graph::Config';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

my @config_vars
  = qw|calendar_url contact_url description drive_id drive_type
  drive_url item_id owner remote|;
my @token_vars
  = qw|access_token refresh_token scope validto next_link delta_link|;

is $package->CONFIG_FILE, 'onedrive.conf', 'Config file';
is_deeply $package->CONFIG_VARS, [@config_vars], 'Config vars';
is $package->TOKEN_FILE, 'token.conf', 'Token file';
is_deeply $package->TOKEN_VARS, [@token_vars], 'Token vars';

# methods

can_ok $package, $_ for @config_vars, @token_vars, qw|expires_in save|;

# test config

ok my $tempdir = Mojo::File::tempdir, 'Create temp folder';
ok my $config = $package->new($tempdir), 'Create empty config';

my %sample_config = (
  access_token  => 'Access token',
  calendar_url  => 'Calendar URL',
  contact_url   => 'Contact URL',
  delta_link    => 'A delta link',
  description   => 'Description with äöüóúőí',
  drive_id      => 'Drive ID',
  drive_type    => 'Drive type',
  drive_url     => 'Drive URL',
  item_id       => 'Item ID',
  owner         => 'Owner',
  refresh_token => 'Refresh Token',
  scope         => 'Scope',
  validto       => '2017-04-15T03:45:53Z',
);

subtest 'Set and check values' => sub {
  is $config->$_($sample_config{$_}), $config, "Set $_"
    for sort keys %sample_config;

  is $config->$_, $sample_config{$_}, "$_ is $sample_config{$_}"
    for sort keys %sample_config;
};

# save and reopen

is $config->save, $config, 'Save file';
ok $config = $package->new($tempdir), 'Load file';

subtest 'Check values' => sub {
  is $config->$_, $sample_config{$_}, "$_ is $sample_config{$_}"
    for sort keys %sample_config;
};

# delta and next link

is $config->delta_link(''), $config, 'Delete delta link';
is $config->delta_link, "$sample_config{drive_url}/root/delta",
  'Default delta link for own drive';

is $config->remote(1), $config, 'Set remote';
is $config->delta_link,
  "$sample_config{drive_url}/items/$sample_config{item_id}/delta",
  'Delta link for remote item';

my $delta_link = 'Delta link';
my $next_link  = 'Next link';

is $config->delta_link($delta_link), $config, 'Set delta link';
is $config->delta_link, $delta_link, "Delta link is $delta_link";
ok !$config->next_link, 'No next link';

is $config->next_link($next_link), $config, 'Set next link';
is $config->next_link, $next_link, "Next link is $next_link";
ok !$config->delta_link, 'No delta link';

is $config->delta_link($delta_link), $config, 'Set delta link';
is $config->delta_link, $delta_link, "Delta link is $delta_link";
ok !$config->next_link, 'No next link';

# expires and valid to

is $config->expires_in(3600), $config, 'Set expiration to 1 hour';
is $config->validto, Mojo::Date->new(time + 3600)->to_datetime,
  'Expires in 1 hour';
