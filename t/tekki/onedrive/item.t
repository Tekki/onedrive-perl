use Mojo::Base -strict;

use Test::More tests => 52;

use Mojo::File;
use Mojo::JSON 'decode_json';

# test values

my %testitem = eval Mojo::File::path(__FILE__)->sibling('testitem_personal.pl')
  ->slurp;

# package

my $package;

BEGIN {
  $package = 'Tekki::Onedrive::Item';
  use_ok $package or exit;
}

my $parent = 'Mojo::Base';

isa_ok $package, $package;
isa_ok $package, $parent;

# constants

# methods

can_ok $package, $_
  for qw|id ctag etag lastmodified name parent_id parent_path|,
  qw|download_url modifiedby sha1 deleted file folder package|,
  qw|exists exists_identical full_path mtime update update_mtime|;

# temp dir

ok my $tempdir = Mojo::File::tempdir, 'Create temp folder';
ok chdir $tempdir, 'Change to temp folder';

# root

ok my $item = $package->new($testitem{root}{json}), 'Root folder';

my %expected = $testitem{root}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

# folder 1

ok $item = $package->new($testitem{folder1}{json}), 'First folder';

%expected = $testitem{folder1}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

# folder 2

ok $item = $package->new($testitem{folder2}{json}), 'Second folder';
%expected = $testitem{folder2}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

my $now = Mojo::Date->new->to_datetime;
ok $item->full_path->make_path, 'Create directory tree';
ok $item->exists,           'Folder exists';
ok $item->exists_identical, 'Folder exists identical';

is $item->mtime, $now, "Last modified $now";

my $lastmodified = $expected{lastmodified};
$lastmodified =~ s/\.\d+Z/Z/;
is $item->update_mtime, $item,         'Update modification time';
is $item->mtime,        $lastmodified, "Last modified $lastmodified";

# package 1 (OneNote)

ok $item = $package->new($testitem{package1}{json}), 'First package';

%expected = $testitem{package1}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

# file 1

ok $item = $package->new($testitem{file1}{json}), 'New file';
%expected = $testitem{file1}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

$now = Mojo::Date->new->to_datetime;
ok $item->full_path->spurt('Wrong content.'), 'Create file';
ok $item->exists, 'File exists';
ok !$item->exists_identical, 'Content is different';

ok $item->full_path->spurt("Original content.\n"), 'Update content';
ok $item->exists_identical, 'Content is equal';
is $item->mtime, $now, "Last modified $now";

$lastmodified = $expected{lastmodified};
$lastmodified =~ s/\.\d+Z/Z/;
is $item->update_mtime, $item,         'Update modification time';
is $item->mtime,        $lastmodified, "Last modified $lastmodified";

# file 1 deleted

ok $item = $package->new($testitem{file1_deleted}{json}), 'Deleted file';
%expected = $testitem{file1_deleted}{content}->%*;

subtest 'Content of item' => sub {
  is $item->$_, $expected{$_}, "$_ is $expected{$_}" for sort keys %expected;
};

# cleanup

ok chdir $ENV{HOME}, 'Change to home';
