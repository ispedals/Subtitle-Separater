#!perl
use v5.16;
use warnings;

use Mojolicious::Lite;

# WebSocket echo service
websocket '/echo' => sub {
	my $self = shift;
	$self->on(message => sub {
		my ($self, $msg) = @_;
		$self->send("echo: $msg");
	});
};

app->start;