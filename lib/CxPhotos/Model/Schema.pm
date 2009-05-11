package CxPhotos::Model::Schema;

use Moose;

extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'CxPhotos::Schema',
);

has 'storage_path' => (
    is => 'rw',
    isa => 'Str'
);

=head1 NAME

CxPhotos::Model::Schema - Catalyst DBIC Schema Model

=head1 SYNOPSIS

This is the thin adapter to L<CxPhotos::Schema>

=head1 ATTRIBUTES

=over

=item storage_path

The path, on disk, to store any files

=back

=head1 METHODS

=head2 new

This overridden new sets the custom accessors from the L<Catalyst> configuration

This allows us to use the schema from outside Catalyst easily

=cut

sub new {
    my $self = shift->next::method(@_);
    $self->schema->storage_path( $self->storage_path );

    return $self;
};

=head1 AUTHOR

J. Shirley

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
