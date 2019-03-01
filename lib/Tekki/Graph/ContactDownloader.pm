package Tekki::Graph::ContactDownloader;
use Mojo::Base -base, -signatures;

use Mojo::File 'path';
use Mojo::Util 'encode';
use Text::CSV_XS 'csv';

# constructor

sub new ($class, $connector) {
  my $self = {connector => $connector};
  return bless $self, $class;
}

# methods

sub synchronize ($self) {
  my $connector = $self->{connector};
  my $config    = $connector->config;

  path($connector->destination, 'contacts')->remove_tree({keep_root => 1});
  my $path = $connector->chdir('contacts');
  $connector->info('Downloading contacts');

  # download
  my @contacts;
  my $i;
  my $url = $config->contact_url . '?$top=1000';
  while ($url) {
    $i++;

    my $response = $connector->get_authorized($url);

    $path->child("contacts_$i.json")->spurt($response->body);

    my $json  = $response->json;
    my $count = $json->{value}->@*;
    $connector->info("$i: $count contacts downloaded");

    push @contacts, $json->{value}->@*;

    $url = $json->{'@odata.nextLink'};
  }

  # export to CSV file
  $self->_to_csv(\@contacts, $path->child('contacts.csv')->to_string);
  $connector->info('Written to CSV file');

  return $self;
}

# internal methods

sub _to_csv ($self, $contacts, $path) {

  # structure
  my @header = split /,/,
    q|Title,First Name,Middle Name,Last Name,Suffix,Company,Department,Job Title,Business Street,Business Street 2,Business Street 3,Business City,Business State,Business Postal Code,Business Country/Region,Home Street,Home Street 2,Home Street 3,Home City,Home State,Home Postal Code,Home Country/Region,Other Street,Other Street 2,Other Street 3,Other City,Other State,Other Postal Code,Other Country/Region,Assistant's Phone,Business Fax,Business Phone,Business Phone 2,Callback,Car Phone,Company Main Phone,Home Fax,Home Phone,Home Phone 2,ISDN,Mobile Phone,Other Fax,Other Phone,Pager,Primary Phone,Radio Phone,TTY/TDD Phone,Telex,Account,Anniversary,Assistant's Name,Billing Information,Birthday,Business Address PO Box,Categories,Children,Directory Server,E-mail Address,E-mail Type,E-mail Display Name,E-mail 2 Address,E-mail 2 Type,E-mail 2 Display Name,E-mail 3 Address,E-mail 3 Type,E-mail 3 Display Name,Gender,Government ID Number,Hobby,Home Address PO Box,Initials,Internet Free Busy,Keywords,Language,Location,Manager's Name,Mileage,Notes,Office Location,Organizational ID Number,Other Address PO Box,Priority,Private,Profession,Referred By,Sensitivity,Spouse,User 1,User 2,User 3,User 4,Web Page|;
  my $i = 0;
  my %column = map { $_, $i++ } @header;

  my %ref = (
    title            => 'Title',
    givenName        => 'First Name',
    middleName       => 'Middle Name',
    surname          => 'Last Name',
    companyName      => 'Company',
    department       => 'Department',
    profession       => 'Job Title',
    assistantName    => 'Assistant\'s Name',
    birthday         => 'Birthday',
    manager          => 'Manager\'s Name',
    officeLocation   => 'Office Location',
    profession       => 'Profession',
    businessHomePage => 'Web Page',
  );

  my %addr_ref = (
    postalCode      => 'Postal Code',
    city            => 'City',
    state           => 'State',
    countryOrRegion => 'Country/Region',
  );

  # process content
  my @rows = (\@header);
  for my $contact ($contacts->@*) {
    my @row = ();
    for my $key (keys %ref) {
      $row[$column{$ref{$key}}] = $contact->{$key};
    }

    # e-mail
    for my $i (1 .. 3) {
      if (my $email = $contact->{emailAddresses}->[$i-1]) {
        my $n = $i == 1 ? '' : " $i";
        $row[$column{"E-mail$n Address"}]      = $email->{address};
        $row[$column{"E-mail$n Display Name"}] = $email->{name};
      }
    }

    # address
    for my $type (qw|home business other|) {
      my $utype   = ucfirst $type;
      my $address = $contact->{"${type}Address"};

      for my $key (keys %addr_ref) {
        $row[$column{"$utype $addr_ref{$key}"}] = $address->{$key};
      }

      if ($address->{street}) {
        my @street_parts = split /, /, $address->{street};
        for my $i (1 .. 3) {
          if (my $street = $street_parts[$i - 1]) {
            my $n =  $i == 1 ? '' : " $i";
            $row[$column{"$utype Street$n"}] = $street;
          }
        }
      }

    }

    push @rows, \@row;
  }

  # write file
  csv(in => \@rows, out => $path, encoding => 'UTF-16');
}

1;

=encoding utf8

=head1 NAME

Tekki::Graph::ContactDownloader - Downloader for contacts.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
