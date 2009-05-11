package CxPhotos::Schema::Photo;

use Moose;

extends 'DBIx::Class';

__PACKAGE__->load_components('Core');
__PACKAGE__->table('photo');

__PACKAGE__->add_columns(
    'id',
    {
        data_type           => 'int',
        size                => 16,
        is_nullable         => 0,
        is_auto_increment   => 1,
    },
    name => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    filename => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    mimetype => {
        data_type   => 'VARCHAR',
        size        => 32,
        is_nullable => 0,
    },
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->has_many(
    'person_links', 'CxPhotos::Schema::Person::Photo',
    { 'foreign.photo_id' => 'self.id' }
);

__PACKAGE__->many_to_many( 'persons' => 'person_links' => 'person' );

__PACKAGE__->has_many(
    'tag_links', 'CxPhotos::Schema::Tag::Photo',
    { 'foreign.photo_id' => 'self.id' }
);

__PACKAGE__->many_to_many( 'tags' => 'tag_links' => 'tag' );

1;
