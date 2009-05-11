package CxPhotos::Controller::Root;

use strict;
use warnings;

use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

CxPhotos::Controller::Root - It all starts here

=head1 DESCRIPTION

This is the base controller that starts all actions.  Below is a listing of all
methods and what they do

=head1 METHODS

=cut

=head2 setup

This is the C<setup> method that initializes the request.  Any matching action
will go through this, so it is an application-wide automatically executed 
action.  For more information, see L<Catalyst::DispatchType::Chained>

=cut

sub setup : Chained('/') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
    # Common things here are to check for ACL and setup global contexts
}

=head2 default 

This is the "not found" action, any request that can't be handled falls to this

This action outputs the Catalyst Welcome Message, generally you want to forward
this to your own C<error/not_found.tt> template.

=cut

sub default : Path {
    my ( $self, $c ) = @_;
    $c->res->status(404);
    $c->response->body( $c->welcome_message );
}

=head2 index

This is the "/" action, dispatched to based on the C<Args(0)>.

=cut

sub index  : Chained('setup') PathPart('') Args(0) { }

sub person : Chained('setup') PathPart('') CaptureArgs(0) { }
sub tag    : Chained('setup') PathPart('') CaptureArgs(0) { }

=head2 end

Attempt to render a view, if needed.  To modify the default view, set the
C<default_view> key in the configuration.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
