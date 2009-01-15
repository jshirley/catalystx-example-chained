package CxPhotos::Controller::Tag;

use strict;
use warnings;

use parent 'Catalyst::Controller';

=head1 NAME

CxPhotos::Controller::Group - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub setup : Chained('.') PathPart('tag') CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->stash->{tag} = $c->model('Schema::Tag')->find( $id );

    unless ( $c->stash->{tag} ) {
        $c->detach('not_found');
    }
    my $p = $c->stash->{tag}->photos->first;
    $c->log->debug( "WTF: $p => " . $p->persons->count );
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
