#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use Mojo::Base -strict;
use Mojo::Util qw|extract_usage getopt|;

use Tekki::Graph::Connector;

getopt
  'a|auth'           => \my $auth,
  'c|count'          => \my $count,
  'd|debug'          => \my $debug,
  'h|help'           => \my $help,
  'r|resync'         => \my $resync,
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
  $conn->debug(1) if $debug;
  $conn->verbose(sub { say Mojo::Util::encode 'UTF-8', $_[0] })
    if $verbose;

  $conn->logout if $logout;

  $conn->authenticate if $auth;

  $conn->test if $test;

  say $conn->count_tasks if $count;

  if ($resync) {
    die 'Cannot resync with pending tasks!' if $conn->count_tasks;
    $conn->config->delta_link('');
    $conn->synchronize({documents_only => 1});
  } elsif ($sync) {
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
    onedrive.pl -r -v destination[s]
    onedrive.pl -s -v destination[s]
    onedrive.pl -x destination[s]

  Options:
    -a, --auth           Authenticate
    -c, --count          Count pending tasks
    -h, --help           Show this message
    -r, --resync         Resync, documents only
    -s, --sync           Synchronize
    -v, --verbose        Print information about the progress
    -x, --logout         Logout
    -C, --calendars-only Synchronize only calendars
    -D, --documents-only Synchronize only documents
    -K, --contacts-only  Synchronize only contacts

=head1 DESCRIPTION

=cut
