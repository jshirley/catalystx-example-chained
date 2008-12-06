package Chained::BaseController::Widget;

use parent qw/Catalyst::Controller Class::Accessor::Fast/;

__PACKAGE__->config(
    source_rs => 'widgets'
);

sub setup : Chained('.') PathPart('widget') CaptureArgs(0) { 
    my ( $self, $c ) = @_;
}

sub list : Chained('setup') PathPart('') Args(0) { 
}

sub object_setup : Chained('setup') PathPart('') CaptureArgs(1) { 
    my ( $self, $c, $id ) = @_;
    my $widget = $c->stash->{$self->source_rs}->find( $id );

    unless ( $widget ) {
        $c->detach('not_found');
    }
}

sub object : Chained('object_setup') PathPart('') Args(0) { 
}

1;

