package CxPhotos::Controller::Tag;

use strict;
use warnings;

use parent 'Catalyst::Controller';

=head1 NAME

CxPhotos::Controller::Tag - The controller to navigate and descend tags

=head1 DESCRIPTION

This controller simply sets up the chain for the next steps, namely the 
L<CxPhotos::Controller::Tag::Photos>.

=head1 METHODS

=cut

=head2 setup

Setup the chain by populating and handling discovering the requested tag.

=cut

sub setup : Chained('.') PathPart('tag') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{tag} = $c->model('Schema::Tag')->find( $id );

    unless ( $c->stash->{tag} ) {
        $c->detach('not_found');
    }
}

=head2 photos

This just continues the chain, with the tag selected via the C<setup> action.

=cut

sub photos : Chained('setup') PathPart('') CaptureArgs(0) { }

=head2 not_found

This is the private not_found method that sets the response code to 404 and
instructs L<Catalyst::Action::RenderView> to use the C<tags/not_found.tt> 
template

=cut

sub not_found : Private {
    my ( $self, $c ) = @_;
    $c->res->status(404);
    $c->stash->{template} = 'tags/not_found.tt';
}

=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
