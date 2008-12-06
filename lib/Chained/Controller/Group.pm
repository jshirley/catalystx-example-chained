package Chained::Controller::Group;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Chained::Controller::Group - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub setup : Chained('.') PathPart('group') CaptureArgs(1) {
    my ( $self, $c ) = @_;
}

sub widget : Chained('setup') PathPart('') CaptureArgs(0) { }

sub object : Chained('setup') PathPart('') Args(0) { }



=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
