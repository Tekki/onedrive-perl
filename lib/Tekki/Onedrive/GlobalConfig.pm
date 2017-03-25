package Tekki::Onedrive::GlobalConfig;

use Mojo::Base -base;
use feature 'signatures';
no warnings 'experimental::signatures';

# constants

use constant {
  AUTH_URL  => 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
  CLIENT_ID => '5a968bc0-ba11-4d28-8837-16f5a8a825aa',
  DRIVE_URL => 'https://graph.microsoft.com/v1.0',
  REDIRECT_URI =>
    'https://login.microsoftonline.com/common/oauth2/nativeclient',
  TOKEN_URL => 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
};

# constructor

sub new ($class) {
  my $self = bless {}, $class;

  my $content;

  $content ||= {
    'Microsoft Graph' => {
      auth_url     => AUTH_URL,
      client_id    => CLIENT_ID,
      drive_url    => DRIVE_URL,
      redirect_uri => REDIRECT_URI,
      token_url    => TOKEN_URL,
    },
  };

  $self->content($content);
  $self->context((keys $content->%*)[0]);

  return $self;
}

# methods

has ['content', 'context'];

sub value ($self, $key, $value = undef) {
  if (defined $value) {
    $self->content->{$self->context}->{$key} = $value;
    return $self;
  } else {
    return $self->content->{$self->context}->{$key};
  }
}

1;

=encoding utf8

=head1 NAME

Tekki::Onedrive::GlobalConfig - The global configuration.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016-2017, Tekki.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
