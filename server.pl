#!perl
use v5.16;
use warnings;

use Mojolicious::Lite;

my $send_to_controller;
my $send_to_video;

# WebSocket echo service
websocket '/messageToController' => sub {
	$send_to_video = shift;
	$send_to_video->on(message => sub {
		my ($self, $msg) = @_;
		$self->send("echo: $msg");
		eval { $send_to_controller->send("echo: $msg");};
	});
};


websocket '/messageToVideo' => sub {
	$send_to_controller = shift;
	 $send_to_controller->on(message => sub {
		my ($self, $msg) = @_;
		eval {$send_to_video->send("echo: $msg");};
	});
};

app->start;