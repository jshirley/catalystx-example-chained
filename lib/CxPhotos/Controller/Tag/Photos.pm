package CxPhotos::Controller::Tag::Photos;

use strict;
use warnings;

use parent 'CxPhotos::ControllerBase::Photos';

__PACKAGE__->config(
    source_rs => 'tag'
);

=head1 NAME

CxPhotos::Controller::Tag::Photos

=cut

=head1 METHODS

There are none, it just uses the L<CxPhotos::ControllerBase::Photos> class!

=head1 CONFIGURATION

The C<source_rs> configuration key instructs the base class what the stash
key is to look for to get photos.  This uses a convention-based method (think
Ruby on Rails) for figuring out what to do.

Essentially, it is like doing:

 $key = $self->source_rs; # Loaded from config
 $c->stash->{$key}->photos;

Take a look at the base class for more details.

=head2 This Controller's URIs

If you look at the Catalyst Server debug output log of the loaded chain
specifications, you'll see that this controller has quite a few actions, though
it doesn't deefine anything other than configuration.  This comes from the
L<CxPhotos::ControllerBase::Photos> class.

The output below shows what actions are defined:

 [debug] Loaded Chained actions:
 .-------------------------------------+--------------------------------------.
 | Path Spec                           | Private                              |
 +-------------------------------------+--------------------------------------+
 | /tag/*/photos                       | /setup (0)                           |
 |                                     | -> /tag (0)                          |
 |                                     | -> /tag/setup (1)                    |
 |                                     | -> /tag/photos (0)                   |
 |                                     | -> /tag/photos/setup (0)             |
 |                                     | => /tag/photos/display               |
 | /tag/*/photos/*                     | /setup (0)                           |
 |                                     | -> /tag (0)                          |
 |                                     | -> /tag/setup (1)                    |
 |                                     | -> /tag/photos (0)                   |
 |                                     | -> /tag/photos/setup (0)             |
 |                                     | -> /tag/photos/object_setup (1)      |
 |                                     | => /tag/photos/object_display        |
 '-------------------------------------+--------------------------------------'

Each step in the Private column is a method that is executed while the request
continues (unless detached).  As you can see, the power of Chained is to build
up, incrementally, what you are working on until you reach the final end point.

=cut

1;
