package CxPhotos::Schema::Person::Photo;

use parent 'DBIx::Class';

__PACKAGE__->load_components('Core');
__PACKAGE__->table('person_photos');

__PACKAGE__->add_columns(
    person_id  => {
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

__PACKAGE__->set_primary_key( 'person_id', 'photo_id' );

__PACKAGE__->belongs_to('person', 'CxPhotos::Schema::Person', 
    { 'foreign.id' => 'self.person_id' }
);
__PACKAGE__->belongs_to('photo', 'CxPhotos::Schema::Photo',
    { 'foreign.id' => 'self.photo_id' }
);

1;
