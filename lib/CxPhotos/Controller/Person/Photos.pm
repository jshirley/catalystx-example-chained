package CxPhotos::Controller::Person::Photos;

use strict;
use warnings;

use parent 'CxPhotos::ControllerBase::Photos';

__PACKAGE__->config(
    source_rs => 'person'
);


1;
