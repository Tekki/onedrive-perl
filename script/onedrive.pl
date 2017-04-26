#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use Mojo::Base -strict;
use Mojo::Util qw|extract_usage getopt|;

use Tekki::Graph::Connector;

getopt
  'a|auth'           => \my $auth,
  'd|debug'          => \my $debug,
  'h|help'           => \my $help,
  's|sync'           => \my $sync,
  'v|verbose'        => \my $verbose,
  'x|logout'         => \my $logout,
  't|test'           => \my $test,
  'C|calendars-only' => \my $calendars_only,
  'D|documents-only' => \my $documents_only,
  'K|contacts-only'  => \my $contacts_only;

die extract_usage if $help;
die 'Destination missing!' unless @ARGV;

for my $destination (@ARGV) {

  my $conn = Tekki::Graph::Connector->new($destination);
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
    $conn->synchronize(
      {
        calendars_only => $calendars_only,
        contacts_only  => $contacts_only,
        documents_only => $documents_only,
      }
    );
  }

}

=encoding utf8

=head1 NAME

onedrive.pl - Perl client for Office 365 services.

=head1 SYNOPSIS

  Usage: onedrive.pl OPTIONS DESTINATION[S]

    onedrive.pl -a destination[s]
    onedrive.pl -s destination[s]
    onedrive.pl -s -v destination[s]
    onedrive.pl -x destination[s]

  Options:
    -a, --auth           Authenticate
    -h, --help           Show this message
    -s, --sync           Synchronize
    -v, --verbose        Print information about the progress
    -x, --logout         Logout
    -C, --calendars-only Synchronize only calendars
    -D, --documents-only Synchronize only documents
    -K, --contacts-only  Synchronize only contacts

=head1 DESCRIPTION

=cut
