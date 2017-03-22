use Mojo::Base -strict;

use Test::More tests => 15;

use Mojo::File;
use Mojo::JSON 'decode_json';

use Tekki::Onedrive::Database;
use Tekki::Onedrive::Item;

# test values

my %testitem
  = eval Mojo::File::path(__FILE__)->sibling('testitem_remote.pl')->slurp;

# test db

ok my $tempdir = Mojo::File::tempdir, 'Create temp folder';
ok my $db = Tekki::Onedrive::Database->new($tempdir), 'Create db object';

# add tasks

my @tasks = map { $testitem{$_}{json} } qw|folder1 file1|;
my $counter = @tasks;

is $db->add_tasks(\@tasks), $counter, "$counter tasks added";

# root folder

ok my $task = $db->next_task, 'Get first task';
ok my $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

ok my $actions = $db->find_differences($item), 'Find differences';

my %expected = (
  create => {
    name        => 'Shared with Cubulon',
    parent_path => '',
    full_path   => 'Shared with Cubulon',
    }
);

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';

# create first file

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name        => 'Document for Cubulon.txt',
    parent_path => '',
    full_path   => 'Document for Cubulon.txt',
    }
);

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';


