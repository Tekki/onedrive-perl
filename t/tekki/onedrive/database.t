use Mojo::Base -strict;
use feature 'signatures';
no warnings 'experimental::signatures';

use Test::More tests => 5;

use Mojo::File;
use Mojo::JSON 'decode_json';

use Tekki::Onedrive::Item;

# package

my $package;

BEGIN {
  $package = 'Tekki::Onedrive::Database';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

my @fields = qw|ctag etag file folder lastmodified modifiedby name
  package parent_id quickxor remote sha1|;

is_deeply $package->ITEM_FIELDS, \@fields, 'List of item fields';

# methods

subtest 'Methods' => sub {
  can_ok $package, $_
    for
    qw|add_tasks create_item delete_item find_item log next_task task_failed|,
    qw|task_ignored task_succeeded update_item|;
};
