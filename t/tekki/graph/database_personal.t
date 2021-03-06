use Mojo::Base -base, -signatures;

use Test::More tests => 104;

use Mojo::File;
use Mojo::JSON 'decode_json';


use Tekki::Graph::Database;
use Tekki::Graph::Item;

# test values

my %testitem
  = eval Mojo::File::path(__FILE__)->sibling('testitem_personal.pl')->slurp;

# test db

ok my $tempdir = Mojo::File::tempdir, 'Create temp folder';
ok my $db      = Tekki::Graph::Database->new($tempdir), 'Create db object';

# add tasks

my @tasks
  = map { $testitem{$_}{json} } qw|root folder1 folder2 file1 folder2 package1|;
my $counter = @tasks;

is $db->add_tasks(\@tasks), $counter, "$counter tasks added";

my %log_entries;
my $log_entry = sub ($item, $action) {
  return {
    item_id      => $item->id,
    name         => $item->name,
    lastmodified => $item->lastmodified,
    modifiedby   => $item->modifiedby,
    action       => $action,
  };
};

# root

ok my $task = $db->next_task, 'Get root item';
ok my $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok my $actions = $db->find_differences($item), 'Find differences';

my %expected = (create => {name => 'root', full_path => 'root',});

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

# create first folder

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (create => {name => 'Dokumente', full_path => 'Dokumente',});

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

ok my $db_item = $db->find_item($item), 'Find item in db';
subtest 'Content of item in db' => sub {
  is $db_item->{item_id}, $item->id, "Item ID is $item->{id}";
  is $db_item->{$_}, $item->$_, "$_ is $item->{$_}"
    for Tekki::Graph::Database->ITEM_FIELDS->@*;
};

# create second folder

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name      => 'Vorlagen',
    full_path => 'Dokumente/Vorlagen',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

ok $db_item = $db->find_item($item), 'Find item in db';
subtest 'Content of item in db' => sub {
  is $db_item->{item_id}, $item->id, "Item ID is $item->{id}";
  is $db_item->{$_}, $item->$_, "$_ is $item->{$_}"
    for Tekki::Graph::Database->ITEM_FIELDS->@*;
};

# create file fails

ok $task = $db->next_task, 'Get next task';
my $task_id = $task->{id};
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name      => 'Testdocument.txt',
    full_path => 'Dokumente/Vorlagen/Testdocument.txt',
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
  is $db_item->{$_}, $item->$_, "$_ is $item->{$_}"
    for Tekki::Graph::Database->ITEM_FIELDS->@*;
};

# create package

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  create => {
    name      => 'Notizbuch von Cubulon',
    full_path => 'Dokumente/Notizbuch von Cubulon',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->create_item($item), $db, 'Add item to db';
is $db->task_succeeded($task, $item, 'create'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'create');

# update first file

is $db->add_tasks([$testitem{file1_updated}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (update => {full_path => 'Dokumente/Vorlagen/Testdocument.txt',});

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'update'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'update');

# rename file

is $db->add_tasks([$testitem{file1_renamed}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name => 'Testdocument Renamed.txt',
    new_path => 'Dokumente/Vorlagen/Testdocument Renamed.txt',
    old_path => 'Dokumente/Vorlagen/Testdocument.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'update'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'update');

# move file

is $db->add_tasks([$testitem{file1_moved}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name => 'Testdocument Renamed.txt',
    new_path => 'Dokumente/Testdocument Renamed.txt',
    old_path => 'Dokumente/Vorlagen/Testdocument Renamed.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'move'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'move');

# rename first folder

is $db->add_tasks([$testitem{folder1_renamed}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name => 'Documents',
    new_path => 'Documents',
    old_path => 'Dokumente',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'move'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'move');

# move file again

is $db->add_tasks([$testitem{file1_moved_again}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected = (
  move => {
    new_name => 'Testdocument Renamed.txt',
    new_path => 'Documents/Vorlagen/Testdocument Renamed.txt',
    old_path => 'Documents/Testdocument Renamed.txt',
  }
);

is_deeply $actions, \%expected, 'Action description';

is $db->update_item($item), $db, 'Update item in db';
is $db->task_succeeded($task, $item, 'move'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'move');

# delete file

is $db->add_tasks([$testitem{file1_deleted}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

%expected
  = (delete => {full_path => 'Documents/Vorlagen/Testdocument Renamed.txt',});

is_deeply $actions, \%expected, 'Action description';

is $db->delete_item($item), $db, 'Delete item in db';
ok !$db->find_item($item), 'Item is no longer in db';
is $db->task_succeeded($task, $item, 'delete'), $db, 'Log entry';
push $log_entries{success}->@*, $log_entry->($item, 'delete');

# remote folder

is $db->add_tasks([$testitem{remote_folder}{json}]), 1, "1 task added";

ok $task = $db->next_task, 'Get next task';
ok $item = Tekki::Graph::Item->new($task->{description}), 'Extract item';

ok $actions = $db->find_differences($item), 'Find differences';

is_deeply $actions, {}, 'No action';

is $db->task_ignored($task, $item), $db, 'Log entry';

# no more tasks

ok !$db->next_task, 'No more tasks';

# check log

ok my $log = $db->log(''), 'Get log';

ok $log->{$_}, "Log has param $_ ($log->{$_})" for qw|log_from log_to|;
for my $result (qw|success error|) {
  ok $log->{$result}, "Log contains data for $result";
  my $count = $log_entries{$result}->@*;
  is $log->{"${result}count"}, $count, "$result count is $count";
}

ok $log = $db->log(Mojo::Date->new->to_datetime), 'Future log';
for my $result (qw|success error|) {
  ok $log->{$result}, "Log contains data for $result";
  ok !$log->{"${result}count"}, "$result count is 0";
}
