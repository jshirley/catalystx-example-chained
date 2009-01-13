package CxPhotos::Controller::Tag::Photos;

use strict;
use warnings;

use parent 'CxPhotos::ControllerBase::Photos';

__PACKAGE__->config(
    source_rs => 'tag'
);

1;
