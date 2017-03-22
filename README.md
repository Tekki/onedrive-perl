# OneDrive-Perl

A Perl client for OneDrive.

**Warning: As long as you see this message, the code in this repo is still experimental. Don't be surprised if you download incompatible changes with git pull.**

## Synopsis

    # authenticate
    onedrive.pl -a [/path/to/destination]

    # synchronize
    onedrive.pl -s [-v] [/path/to/destination]

    # logout
    onedrive.pl -x [/path/to/destination]

## Features

OneDrive-Perl is a backup client for OneDrive, i.e. a program that mirrors all the changes on your cloud drive to a local machine, using the [Graph API](https://developer.microsoft.com/en-us/graph/) and obviously written in [Perl](https://www.perl.org). It is allowed to crash, but not to lose a single operation. It doesn't perform a two-way synchronization (and probably will never do).

The next steps are:
  * ~~support for remote items (files and folders shared with me)~~
  * support for OneDrive for Business
  * support for SharePoint
  * possibility to upload a big amount of data to OneDrive and SharePoint

## Installation

OneDrive-Perl needs Perl 5.24.0 or highter. It is recommended to use a [Perlbrew](https://perlbrew.pl) environment. After you have installed perlbrew, type as user:

    perlbrew install 5.24.1
    perlbrew switch 5.24.1

Next you need the most recent versions of the following Perl modules:
  * Data::Dump
  * Mojolicious
  * Mojo::SQLite

Don't use the outdated packages included in your distribution, instead install them from CPAN with

    cpanm Data::Dump Mojolicious Mojo::SQLite

Now you can install OneDrive-Perl.

    git clone https://github.com/Tekki/onedrive-perl.git

Update the code with

    cd path/to/onedrive-perl
    git pull

## Usage

### Paths

In the following, ***onedrive.pl*** refers to the full path to the onedrive script, for example

    ~/git/onedrive-perl/script/onedrive.pl

***destination*** is the path where the content of your library will be copied to, for example

    ~/onedrive/personal

It has the following subdirectories:

    destination
    |-- config
    |-- documents

***config*** is used to store internal data, ***documents*** is the place where the files from OneDrive will be found.

If the destination doesn't exist, the complete directory tree is created automatically.

The destination is optional and defaults to the actual directory. The following commands are equal

    onedrive.pl [options]
    onedrive.pl [options] ./

### Authenticate

    onedrive.pl -a destination
    onedrive.pl --authenticate destination

This will display a link like

    https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=...

that you have to open in your browser. Log in with your Microsoft account and allow the application to access your OneDrive. You will be redirected to a blank page on microsoftonline.com. Copy the resulting URL from your browser back to

    Paste the response URL:

and press ENTER. If the authentication is successful, you can choose which drive you want to synchronize and give it a description.

    1: Tekki / OneDrive Personal
    2: Bonnie Parker / Shared with Tekki
    Select drive [1]:
    Description [Tekki / OneDrive Personal]:

If you want to keep the proposed values, simply press ENTER.

### Synchronize

    onedrive.pl -s destination
    onedrive.pl --synchronize destination

This will synchronize your OneDrive with the destination and (hopefully) exit without a message. If you want to see some information about what the program is doing, use one of

    onedrive.pl -s -v destination
    onedrive.pl --synchronize --verbose destination

***Crashes:*** At this moment, the program will crash maybe once an hour, especially if errors and timeouts on the side of Microsoft occur. As it develops, these crashes will be less frequent. ***But*** even now you should be able to restart it without creating a single inconsistency.

### Logout

    onedrive.pl -x destination
    onedrive.pl --logout destination

This disconnects the destination from your OneDrive. To revoke all the rights you gave to this program, go to your [Microsoft Account](https://account.live.com/consent/Manage) and delete it from the list. Of course you can authenticate again any time.
