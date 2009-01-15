package CxPhotos::Schema::Tag::Photo;

use parent 'DBIx::Class';

__PACKAGE__->load_components('Core');
__PACKAGE__->table('photo_tags');

__PACKAGE__->add_columns(
    tag_id  => {
        data_type       => 'int',
        is_nullable     => 0,
        size            => 16,
        is_foreign_key  => 1,
    },
    photo_id  => {
        data_type       => 'int',
        is_nullable     => 0,
        size            => 16,
        is_foreign_key  => 1,
    },
);

__PACKAGE__->set_primary_key( 'tag_id', 'photo_id' );

__PACKAGE__->belongs_to('tag', 'CxPhotos::Schema::Tag', 'tag_id');
__PACKAGE__->belongs_to('photo', 'CxPhotos::Schema::Photo', 'photo_id');

1;
