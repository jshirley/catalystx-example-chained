package CxPhotos::ControllerBase::Photos;

use Moose;

extends 'Catalyst::Controller';

__PACKAGE__->config(
    source_rs => 'person',
    stash_key => 'photos',
    method    => 'photos'
);

has 'source_rs' => (
    is => 'rw',
    isa => 'Str'
);

has 'stash_key' => (
    is => 'rw',
    isa => 'Str'
);

has 'method' => (
    is => 'rw',
    isa => 'Str'
);

=head1 NAME

CxPhotos::ControllerBase::Photos

=head1 SYNOPSIS

This controller provides generic actions on any L<DBIx::Class> object that
has a 'photos' relationship.

It defines Chain-based actions to be applied to the subclasses to provide all
actions that someone may want relating to photos.

=head1 ATTRIBUTES

=head2 source_rs

This is the attribute to instruct the base controller where to look for photos.

It essentially becomes (anything with a C<photos> method will work):

 $c->stash->{ $self->source_rs }->photos;

(The _rs stands for result source, from L<DBIx::Class> terminology)

=head2 stash_key

Where do we store the resulting information?

=head2 method

Defaults to 'photos', and is simply the method that is called on the setup
result source.  

=head1 A NOTE ABOUT ROLES

If you are astute and knowledgeable of roles, you may have noticed my usage of
the terms "provides generic actions" and "applied".  This are more accurately
described as "traits" of a package.  In other words, this could very easily be
a role applied to a controller.

In Moose syntax, something like the following would be ideal:

 package MyApp::Controller::Person;

 use Moose;
 extends 'Catalyst::Controller';

 with 'MyApp::Roles::Photos';

 1;

Then, you would get additional actions applied to your class in a more
meaningful and safe fashion.  I highly recommend reading Chromatic's writings
on the subject, as it is exquisitely enlightening:

=over 

=item Perl Roles versus Duck Typing

This article discussing how roles differ from "Other Things", since it at first
glance Roles seem merely conceptual.  This helps clarify the concepts into
meaningful technology:

L<http://www.modernperlbooks.com/mt/2009/05/perl-roles-versus-duck-typing.html>

=item Perl Roles versus Inheritance

This method in this application is basically using Inheritance instead of Roles,
when we really mean Roles from a semantic perspecitve. Chromatic has addressed 
this point, and design ideas, at:

L<http://www.modernperlbooks.com/mt/2009/05/perl-roles-versus-inheritance.html>

=back

There is more reading on L<http://www.modernperlbooks.com> that I encourage you
to read, but for now that should suffice.

I didn't want followers of this application to be stunted by applying Roles into
the mix along with other new concepts.

=cut

sub setup : Chained('.') PathPart('photos') CaptureArgs(0) { 
    my ( $self, $c ) = @_;
    my $method    = $self->method;
    my $stash_key = $self->stash_key;
    my $source_rs = $self->source_rs;

    $c->stash->{$stash_key} = $c->stash->{$source_rs}->$method
}

sub display : Chained('setup') PathPart('') Args(0) { 
}

sub object_setup : Chained('setup') PathPart('') CaptureArgs(1) { 
    my ( $self, $c, $id ) = @_;

    my $photo = $c->stash->{$self->stash_key}->find( $id );

    unless ( $photo ) {
        $c->detach('not_found');
    }
}

sub object_display : Chained('object_setup') PathPart('') Args(0) { 
}

1;

