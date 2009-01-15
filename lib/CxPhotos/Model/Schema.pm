package CxPhotos::Model::Schema;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'CxPhotos::Schema',
    
);

=head1 NAME

CxPhotos::Model::Schema - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<CxPhotos>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<CxPhotos::Schema>

=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
