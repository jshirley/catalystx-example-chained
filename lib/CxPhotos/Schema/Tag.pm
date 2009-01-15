package CxPhotos::Schema::Tag;

use parent 'DBIx::Class';

__PACKAGE__->load_components('Core');

__PACKAGE__->table('tag');

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
);

__PACKAGE__->set_primary_key( 'id' );

__PACKAGE__->has_many(
    'photo_links', 'CxPhotos::Schema::Tag::Photo',
    { 'foreign.tag_id' => 'self.id' }
);

__PACKAGE__->many_to_many( 'photos' => 'photo_links' => 'photo' );

1;
