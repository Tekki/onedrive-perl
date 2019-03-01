#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use App::Prove;

chdir $FindBin::Bin;
my $app = App::Prove->new;
my @args = qw|-r -I ../lib -l ../t|;
$app->process_args(@args);
$app->run;

=encoding utf8

=head1 NAME

test.pl - Script to run all tests.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2019, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
