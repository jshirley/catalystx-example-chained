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
controller namespace)

=cut

sub setup : Chained('.') PathPart('person') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{person} = $c->model('Schema::Person')->find( $id );

    unless ( $c->stash->{person} ) {
        $c->detach('not_found');
    }
}

sub photos : Chained('setup') PathPart('') CaptureArgs(0) { }

sub display : Chained('setup') PathPart('') Args(0) { }

=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
