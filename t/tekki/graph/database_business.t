use Mojo::Base -strict;

use Test::More tests => 42;

use Mojo::File;
use Mojo::JSON 'decode_json';

use Tekki::Graph::Database;
use Tekki::Graph::Item;

# test values

my %testitem
  = eval Mojo::File::path(__FILE__)->sibling('testitem_business.pl')->slurp;

# test db

ok my $tempdir = Mojo::File::tempdir, 'Create temp folder';
ok my $db = Tekki::Graph::Database->new($tempdir), 'Create db object';

# add tasks

my @tasks = map { $testitem{$_}{json} }
  qw|root folder1 folder2 folder3 file1 file2 folder1 folder2 file1 file2|;
my $counter = @tasks;

is $db->add_tasks(\@tasks), $counter, "$counter tasks added";
is $db->count_tasks, 6, '6 pending tasks';

# root

ok my $task = $db->next_task, 'Get root item';
ok my $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok my $actions = $db->find_differences($item), 'Find differences';

my %expected = (create => {name => 'root', full_path => 'root',});

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';

# create folders

my @folders = (
  {name => 'First Folder', full_path => 'First Folder'},
  {
    name      => 'Zentralbibliothek Zürich',
    full_path => 'First Folder/Zentralbibliothek Zürich'
  },
  {
    name =>
      'Российская государственная библиотека',
    full_path =>
      'First Folder/Российская государственная библиотека'
  },
);

subtest 'Create folders' => sub {
  for my $folder (@folders) {
    ok $task = $db->next_task, 'Get next task';
    ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

    ok $actions = $db->find_differences($item), 'Find differences';

    %expected = (
      create => {name => $folder->{name}, full_path => $folder->{full_path},});

    is_deeply $actions, \%expected, 'Action description';

    is $db->create_item($item), $db, 'Add item to db';
    is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
  }
};

# create files

my @files = (
  {
    name      => 'Über uns.txt',
    full_path => 'First Folder/Zentralbibliothek Zürich/Über uns.txt'
  },
  {
    name => 'Новости.txt',
    full_path =>
      'First Folder/Российская государственная библиотека/Новости.txt'
  },
);

subtest 'Create files' => sub {
  for my $file (@files) {
    ok $task = $db->next_task, 'Get next task';
    ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

    ok $actions = $db->find_differences($item), 'Find differences';

    %expected
      = (create => {name => $file->{name}, full_path => $file->{full_path},});

    is_deeply $actions, \%expected, 'Action description';

    is $db->create_item($item), $db, 'Add item to db';
    is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
  }
};

# move first file

is $db->add_tasks([$testitem{file1_moved}{json}]), 1, "1 task added";
is $db->count_tasks, 1, '1 pending task';

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name => 'Über uns.txt',
    new_path => 'First Folder/Über uns.txt',
    old_path => 'First Folder/Zentralbibliothek Zürich/Über uns.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'move'), $db, 'Log entry';

# add tasks

@tasks = map { $testitem{$_}{json} }
  qw|file1_deleted folder1_deleted folder2_deleted|;
$counter = @tasks;

is $db->add_tasks(\@tasks), $counter, "$counter tasks added";
is $db->count_tasks, $counter, "$counter pending tasks";

# delete first file

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (delete => {full_path => 'First Folder/Über uns.txt'});

is_deeply $actions, \%expected, 'Action description';

is $db->delete_item($item), $db, 'Delete item from db';
is $db->task_succeeded($task, $item, 'delete'), $db, 'Log entry';

# delete first folder

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (delete => {full_path => 'First Folder'});

is_deeply $actions, \%expected, 'Action description';

is $db->delete_item($item), $db, 'Delete item from db';
is $db->task_succeeded($task, $item, 'delete'), $db, 'Log entry';

ok my $itemcount = $db->handle->query('SELECT count(*) FROM item')->array,
  'Count items';

is $itemcount->[0], 1, 'Only root item remains';

# try to delete second folder

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

is_deeply $actions, {}, 'Folder is already deleted';

is $db->task_ignored($task, $item), $db, 'Log entry';

# no more tasks

ok !$db->next_task, 'No more tasks';
