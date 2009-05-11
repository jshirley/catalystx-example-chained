package CxPhotos::Schema;

use parent 'DBIx::Class::Schema';

use Moose;
use MooseX::Types::Path::Class;

use Carp;
use Text::xSV;

__PACKAGE__->load_namespaces( result_namespace => '+CxPhotos::Schema' );

has 'storage_path' => (
    is       => 'rw',
    isa      => 'Path::Class::Dir',
    coerce   => 1,
);

sub deploy {
    my ( $self, $properties ) = @_;
    
    my $data_import = delete $properties->{import};

    my $key_check_off;
    my $key_check_on;
    if ( $self->storage->isa('DBIx::Class::Storage::DBI::mysql') ) {
        $key_check_off = "SET FOREIGN_KEY_CHECKS = 0";
        $key_check_on  = "SET FOREIGN_KEY_CHECKS = 1";
    }

    my $populate_txn = sub {
        $self->SUPER::deploy($properties, @_);

        return unless $data_import and ref $data_import eq 'HASH';
        $self->storage->dbh->do($key_check_off) if $key_check_off;

        foreach my $data ( keys %$data_import ) {
            my $rs = $self->resultset($data);
            unless ( $rs ) {
                carp "Unknown result set in import: $data"
            }
            my $csv = Text::xSV->new(
                error_handler => sub { die @_; }
            );
            $csv->open_file($data_import->{$data});
            $csv->read_header;
            foreach my $field ( $csv->get_fields ) {
                if ( lc($field) ne $field ) {
                    $csv->alias($field, lc($field));
                }
            }

            while ( my $row = $csv->fetchrow_hash ) {
                $rs->create($row);
            }
        }
        $self->storage->dbh->do($key_check_on) if $key_check_on;
    };
    $self->txn_do( $populate_txn );
    if ( $@ ) {
        die "Unable to deploy and populate data: $@";
    }
}

1;
