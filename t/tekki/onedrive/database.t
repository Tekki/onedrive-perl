use Mojo::Base -strict;
use feature 'signatures';
no warnings 'experimental::signatures';

use Test::More tests => 112;

use Mojo::File;
use Mojo::JSON 'decode_json';

use Tekki::Onedrive::Item;

# test values

my %testitem = eval Mojo::File::path(__FILE__)->sibling('testitem_personal.pl')
  ->slurp;

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

my @fields = qw|ctag etag lastmodified name parent_id parent_path
  modifiedby sha1 file folder package|;

is_deeply $package->FIELDS, \@fields, 'List of item fields';

# methods

can_ok $package, $_
  for qw|add_tasks create_item delete_item find_item log next_task task_failed|,
  qw|task_ignored task_succeeded update_item|;

# test db

ok my $tempdir = Mojo::File::tempdir, 'Create temp folder';
ok my $db = $package->new($tempdir);

# add tasks

my @tasks = map { $testitem{$_}{json} }
  qw|folder1 folder2 file1_deleted file1 folder2 package1
  file1_updated file1_renamed file1_moved file1_deleted|;
my $counter = @tasks;

is $db->add_tasks(\@tasks), $counter, "$counter tasks added";

my %log_entries;
my $log_entry = sub ($item, $action) {
  return {
    item_id      => $item->id,
    name         => $item->name,
    lastmodified => $item->lastmodified,
    modifiedby   => $item->modifiedby,
    action       => 'create',
  };
};

# create first folder

ok my $task = $db->next_task, 'Get first task';
ok my $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

my %expected = $testitem{folder1}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok my $actions = $db->find_differences($item), 'Find differences';

%expected
  = (
  create => {name => 'Dokumente', parent_path => '', full_path => 'Dokumente',}
  );

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

ok my $db_item = $db->find_item($item), 'Find item in db';
subtest 'Content of item in db' => sub {
  is $db_item->{item_id}, $item->id, "Item ID is $item->{id}";
  is $db_item->{$_}, $item->$_, "$_ is $item->{$_}" for @fields;
};

# create second folder

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{folder2}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name        => 'Vorlagen',
    parent_path => 'Dokumente',
    full_path   => 'Dokumente/Vorlagen',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

ok $db_item = $db->find_item($item), 'Find item in db';
subtest 'Content of item in db' => sub {
  is $db_item->{item_id}, $item->id, "Item ID is $item->{id}";
  is $db_item->{$_}, $item->$_, "$_ is $item->{$_}" for @fields;
};

# delete file before it exists

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{file1_deleted}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';
is_deeply $actions, {}, 'No action';

is $db->task_ignored($task, $item), $db, 'Log entry';
push $log_entries{ignored}->@*, $log_entry->($item, 'ignored');

# create file fails

ok $task = $db->next_task, 'Get next task';
my $task_id = $task->{id};
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{file1}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name        => 'Testdocument.txt',
    parent_path => 'Dokumente/Vorlagen',
    full_path   => 'Dokumente/Vorlagen/Testdocument.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->task_failed($task, $item, 'create'), $db, 'Log entry';
push $log_entries{error}->@*, $log_entry->($item, 'create');

# create file again

ok $task = $db->next_task, 'Get next task';
is $task->{id}, $task_id, 'The same task again';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

ok $db_item = $db->find_item($item), 'Find item in db';
subtest 'Content of item in db' => sub {
  is $db_item->{item_id}, $item->id, "Item ID is $item->{id}";
  is $db_item->{$_}, $item->$_, "$_ is $item->{$_}" for @fields;
};

# skip create folder

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{folder2}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';
is_deeply $actions, {}, 'No action';

is $db->task_ignored($task, $item), $db, 'Log entry';
push $log_entries{ignored}->@*, $log_entry->($item, 'ignored');

# create package

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{package1}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name        => 'Notizbuch von Cubulon',
    parent_path => 'Dokumente',
    full_path   => 'Dokumente/Notizbuch von Cubulon',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

# update first file

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{file1_updated}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (update => {full_path => 'Dokumente/Vorlagen/Testdocument.txt',});

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'update'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'update');

# rename file

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{file1_renamed}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name        => 'Testdocument Renamed.txt',
    new_parent_path => 'Dokumente/Vorlagen',
    new_path        => 'Dokumente/Vorlagen/Testdocument Renamed.txt',
    old_path        => 'Dokumente/Vorlagen/Testdocument.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'update'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'update');

# move file

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{file1_moved}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name        => 'Testdocument Renamed.txt',
    new_parent_path => 'Dokumente',
    new_path        => 'Dokumente/Testdocument Renamed.txt',
    old_path        => 'Dokumente/Vorlagen/Testdocument Renamed.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'update'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'update');

# delete file

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Onedrive::Item->new($task->{description}), 'Extract item';

%expected = $testitem{file1_deleted}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (delete => {full_path => 'Dokumente/Testdocument Renamed.txt',});

is_deeply $actions, \%expected, 'Action description';

is $db->delete_item($item), $db, 'Delete item in db';
ok !$db->find_item($item), 'Item is no longer in db';
is $db->task_succeeded($task, $item, 'delete'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'delete');

# no more tasks

ok !$db->next_task, 'No more tasks';

# check log

ok my $log = $db->log(''), 'Get log';

ok $log->{$_}, "Log has param $_ ($log->{$_})" for qw|log_from log_to|;
for my $result (qw|success error ignored|) {
  ok $log->{$result}, "Log contains data for $result";
  my $count = $log_entries{$result}->@*;
  is $log->{"${result}count"}, $count, "$result count is $count";
}

ok $log = $db->log(Mojo::Date->new->to_datetime), 'Future log';
for my $result (qw|success error ignored|) {
  ok $log->{$result}, "Log contains data for $result";
  ok !$log->{"${result}count"}, "$result count is 0";
}
