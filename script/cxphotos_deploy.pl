#!/usr/bin/perl -w

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Pod::Usage;
use Getopt::Long;

use CxPhotos;

my ( $help, $deploy, $ddl, $drop_tables ) = ( 0, 1, 0, 0 );

GetOptions(
    'help|?'   => \$help,
    'deploy|d' => \$deploy,
    'ddl'      => \$ddl,
    'drop'     => \$drop_tables,
);

pod2usage(1) if $help;

my $schema = CxPhotos->model('Schema')->schema;

if ( $ddl ) {
    $schema->create_ddl_dir(
        [ 'SQLite', 'MySQL' ],
        $SoccerRoster::VERSION,
        CxPhotos->path_to('sql')
    );
}
elsif ( $deploy ) {
    $schema->deploy({ 
        add_drop_table => $drop_tables,
        import => {
            'Person' => CxPhotos->path_to('data/people.csv'),
            'Tag'    => CxPhotos->path_to('data/tags.csv'),
            'Photo'  => CxPhotos->path_to('data/photos.csv'),
            'Person::Photo' => CxPhotos->path_to('data/person_photos.csv'),
            'Tag::Photo'    => CxPhotos->path_to('data/photo_tags.csv'),
        }
    });
} else {
    pod2usage(1);
}

1;

