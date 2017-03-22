#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use Mojo::Base -strict;
use Mojo::Util qw|extract_usage getopt|;

use Tekki::Onedrive::Connector;

getopt
  'a|auth'    => \my $auth,
  'd|debug'   => \my $debug,
  'h|help'    => \my $help,
  's|sync'    => \my $sync,
  'v|verbose' => \my $verbose,
  'x|logout'  => \my $logout,
  't|test'    => \my $test;

die extract_usage if $help;

my $conn = Tekki::Onedrive::Connector->new;
$conn->verbose(1) if $verbose;

if (my $dest = shift) {
  $conn->destination($dest);
}

if ($logout) {
  $conn->logout;
}

if ($auth) {
  $conn->authenticate;
}

if ($sync) {
  $conn->synchronize;
}

if ($test) {
  $conn->test;
}


=encoding utf8

=head1 NAME

onedrive.pl - Perl client for OneDrive.

=head1 SYNOPSIS

  Usage: onedrive.pl [OPTIONS] [DESTINATION]

    onedrive.pl -a ./destination
    onedrive.pl -s ./destination
    onedrive.pl -s -v ./destination
    onedrive.pl -x ./destination

  Options:
    -a, --auth         Authenticate
    -h, --help         Show this message
    -s, --sync         Synchronize
    -v, --verbose      Print debug information
    -x, --logout       Logout

=head1 DESCRIPTION

=cut
