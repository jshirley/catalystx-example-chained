package CxPhotos::Controller::Person;

use strict;
use warnings;

use parent 'Catalyst::Controller';

=head1 NAME

CxPhotos::Controller::Person - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 setup

Chained('.') chains to the parent namespace, to a method named 'person' (this
controller's default namespace)

=cut

sub setup : Chained('.') PathPart('person') CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{result} = $c->model('Schema::Person');
}

=head2 root

This action chains to the setup action, and has no path part. This allows it
to execute via the URL C</person>

=cut

sub root : Chained('setup') PathPart('') Args(0) { }

=head2 setup_person(1)

This sets up the person, via the URL C</person/$id> and, if unable to find them
by inspecting the stashed result set, detaches to the 404 "Not Found" action

=cut

sub setup_person : Chained('setup') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{person} = $c->stash->{result}->find( $id );

    unless ( $c->stash->{person} ) {
        $c->detach('not_found');
    }
}

=head2 display

Displays the currently discovered person in the URL.  Since this method has
the attribute C<PathPart('')> there is no end part to the path, and it is 
accessible simply at C</person/$id>

=cut

sub display : Chained('setup_person') PathPart('') Args(0) { }

=head2 photos

This is an intermediary chain that connects to the
L<CxPhotos::Controller::Person::Photos> controller.

=cut

sub photos : Chained('setup_person') PathPart('') CaptureArgs(0) { }

=head2 not_found

This private not_found action sets the proper status code (404) and the template
in the stash.  It instructs L<Catalyst::Action::RenderView> to use
C<person/not_found.tt> for a custom 404 page.

Of note, since we have the result set populated in the stash up the chain, the
404 page can query the results to give a list of people.

=cut

sub not_found : Private {
    my ( $self, $c ) = @_;
    $c->res->status(404);
    $c->stash->{template} = 'person/not_found.tt';
}

=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
