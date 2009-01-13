package CxPhotos::ControllerBase::Photos;

use parent qw/Catalyst::Controller Class::Accessor::Fast/;

__PACKAGE__->config(
    source_rs => 'person',
    stash_key => 'photos',
    method    => 'photos'
);

__PACKAGE__->mk_accessors( qw/source_rs stash_key method/ );

sub setup : Chained('.') PathPart('photos') CaptureArgs(0) { 
    my ( $self, $c ) = @_;
    my $method    = $self->method;
    my $stash_key = $self->stash_key;
    my $source_rs = $self->source_rs;

    $c->stash->{$stash_key} = $c->stash-{$source_rs}->$method
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

