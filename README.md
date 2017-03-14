# OneDrive-Perl
Perl client for OneDrive

**Warning: As long as you see this message, the code in this repo is still experimental. Don't be surprised if you download incompatible changes with git pull.**

## Features

This is a backup client for OneDrive, i.e. a program that mirrors all the changes on the cloud drive to a local machine. It is not a sync client (and probably will never be).

Next steps are:
  * support for OneDrive for Business
  * support for SharePoint
  * possibility to upload a big amount of data to OneDrive and SharePoint

## Installation

First you need Perl 5.24. We recommend the use of a [Perlbrew](https://perlbrew.pl) environment. As user, type:

    perlbrew install 5.24.1
    perlbrew switch 5.24.1

Then you need the most recent versions of the following Perl modules:
  * Config::Tiny
  * Data::Dump
  * Mojolicious
  * Mojo::SQLite

Don't use the packages included in your distribution, instead install them with CPANM.

    cpanm Config::Tiny Data::Dump Mojolicious Mojo::SQLite

Now you can install this code.

    git clone https://github.com/Tekki/onedrive-perl.git
