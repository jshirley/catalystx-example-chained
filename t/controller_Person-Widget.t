use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Chained' }
BEGIN { use_ok 'Chained::Controller::Person::Widget' }

ok( request('/person/widget')->is_success, 'Request should succeed' );


