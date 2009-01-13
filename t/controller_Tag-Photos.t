use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'CxPhotos' }
BEGIN { use_ok 'CxPhotos::Controller::Tag::Photos' }

ok( request('/tag/car/photos')->is_success, 'Request should succeed' );


