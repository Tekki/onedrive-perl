# OneDrive-Perl

A Perl client for Office 365 services like OneDrive Personal or OneDrive for Business.

## Synopsis

    # authenticate
    onedrive.pl -a [-v] /path/to/destination

    # synchronize
    onedrive.pl -s [-c] [-v] [-C|-D|-K] /path/to/destination

    # logout
    onedrive.pl -x /path/to/destination

## Features

OneDrive-Perl is a backup client for Office 365 services like OneDrive Personal or OneDrive for Business, i.e. a program that mirrors all the changes on your cloud service to a local machine, using the [Graph API](https://developer.microsoft.com/en-us/graph/) and obviously written in [Perl](https://www.perl.org). It is allowed to crash, but not to lose a single operation. It is a backup client, so it has no write permissions and doesn't perform a two-way synchronization.

## Installation

OneDrive-Perl needs Perl 5.24.0 or highter. It is recommended to use a [Perlbrew](https://perlbrew.pl) environment. After you have installed perlbrew, type as user:

    perlbrew install 5.24.1
    perlbrew switch 5.24.1

Next you need the most recent versions of the following Perl modules:
  * Data::Dump
  * Data::ICal
  * IO::Socket::SSL
  * Mojolicious
  * Mojo::SQLite
  * Text::CSV_XS

Don't use the outdated packages included in your distribution, instead install them from CPAN with

    cpanm Data::Dump Data::ICal IO::Socket::SSL Mojolicious Mojo::SQLite Text::CSV_XS

IO::Socket::SSL depends on the SSL development libraries. On Debian they are called `libssl-dev`.

Now you can install OneDrive-Perl.

    git clone https://github.com/Tekki/onedrive-perl.git

Update the code with

    cd path/to/onedrive-perl
    git pull

## Usage

### Paths

In the following, `onedrive.pl` refers to the full path to the onedrive script, for example

    ~/git/onedrive-perl/script/onedrive.pl

`destination[s]` is the path where the content of your library will be copied to, for example

    onedrive.pl OPTIONS ~/onedrive/personal

You can call it on multiple destinations

    onedrive.pl OPTIONS ~/onedrive/personal ~/onedrive/shared_a ~/onedrive/shared_b

It has the following subdirectories:

    destination
    |-- .config
    |-- calendars
    |-- contacts
    |-- documents

`.config` is used to store internal data, `contacts` to backup the contacts, and `documents` is the place where the files from OneDrive will be downloaded. The
calendar events are copied to subfolders of `calendars`.

If the destination doesn't exist, the directory tree is created as necessary.

### Authenticate

    onedrive.pl -a destination[s]
    onedrive.pl --authenticate destination[s]

This will display a link like

    https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=...

that you have to open in your browser. Log in with your Microsoft account and allow the application to access your Office 365 instance. You will be redirected to a blank page on microsoftonline.com. Copy the resulting URL from your browser back to

    Paste the response URL:

and press ENTER. If the authentication is successful, you can choose which drive you want to synchronize and give it a description.

#### OneDrive Personal

On OneDrive Personal, you get a dialog like the following:

    1: Tekki / OneDrive Personal
    2: Bonnie Parker / Shared with Tekki
    Select drive [1]:
    Description [Tekki / OneDrive Personal]:

To keep the proposed values, simply press ENTER.

#### OneDrive for Business and SharePoint

If you are logged in with a business account, you are asked to provide a SharePoint URL.

    To backup a SharePoint drive, enter the main URL of the site.
    SharePoint URL []:

The main URL starts with `your_company.sharepoint.com` and ends with `SitePages/Homepage.aspx`.
If you don't enter a URL, a connection to your OneDrive for Business will be made, otherwise you can choose between the drives of your SharePoint site.

    1: Contoso / Teamwebsite Documents
    2: Contoso / Teamwebsite ...
    ...
    Select drive [1]:

### Synchronize

    onedrive.pl -s destination[s]
    onedrive.pl --synchronize destination[s]

This will synchronize your OneDrive with the destination and (hopefully) exit without a message. If you want to see some information about what the program is doing, use one of

    onedrive.pl -s -v destination[s]
    onedrive.pl --synchronize --verbose destination[s]

You can limit the synchronization to a specified area with

    onedrive-pl -s -C destination[s]
    onedrive-pl --synchronize --calendars-only destination[s]

    onedrive-pl -s -D destination[s]
    onedrive-pl --synchronize --documents-only destination[s]

    onedrive-pl -s -K destination[s]
    onedrive-pl --synchronize --contacts-only destination[s]

To display the number of pending tasks write

onedrive-pl -c destination[s]

***Crashes:*** At this moment, the program will crash maybe once a day, especially if errors on the side of Microsoft occur. As it develops, these crashes will be less frequent. ***But*** even now you should be able to restart it without creating a single inconsistency.

### Logout

    onedrive.pl -x destination[s]
    onedrive.pl --logout destination[s]

This disconnects the destination from your OneDrive, but keeps the details of the connection and the database of the documents. You can authenticate again any time.
To revoke all the rights you gave to this program, go to your [Personal Microsoft Account](https://account.live.com/consent/Manage) or to your [Office 365 Business Account](https://portal.office.com/account/#apps) and delete it from the list.
