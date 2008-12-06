use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Chained' }
BEGIN { use_ok 'Chained::Controller::Group' }

ok( request('/group')->is_success, 'Request should succeed' );


