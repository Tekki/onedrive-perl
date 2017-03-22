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
die 'Destination missing!' unless @ARGV;

for my $destination (@ARGV) {

  my $conn = Tekki::Onedrive::Connector->new($destination);
  $conn->debug(1)   if $debug;
  $conn->verbose(1) if $verbose;

  if ($logout) {
    $conn->logout;
  }

  if ($auth) {
    $conn->authenticate;
  }

  if ($test) {
    $conn->test;
  }

  if ($sync) {
    $conn->synchronize;
  }

}

=encoding utf8

=head1 NAME

onedrive.pl - Perl client for OneDrive.

=head1 SYNOPSIS

  Usage: onedrive.pl OPTIONS DESTINATION

    onedrive.pl -a ./destination
    onedrive.pl -s ./destination
    onedrive.pl -s -v ./destination
    onedrive.pl -x ./destination

  Options:
    -a, --auth         Authenticate
    -h, --help         Show this message
    -s, --sync         Synchronize
    -v, --verbose      Print information about the progress
    -x, --logout       Logout

=head1 DESCRIPTION

=cut
