package CxPhotos;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root 
#                 directory

use parent qw/Catalyst/;

our $VERSION = '0.01';

# Configure the application. 
#
# Note that settings in chained.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'Chained' );

# Start the application
__PACKAGE__->setup(qw/
    ConfigLoader Static::Simple
/);


=head1 NAME

CxPhotos - Catalyst example application

=head1 SYNOPSIS

This application is for demonstrating the ideas of controller base classes and
<Catalyst::DispatchType::Chained>.

To start this application, please run:

    script/cxphotos_server.pl -d

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Chained::Controller::Root>, L<Catalyst>

=head1 AUTHOR

J. Shirley C<< <code@coldhardcode.com> >>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
