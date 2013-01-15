#!perl
use v5.16;
use warnings;

use Mojolicious::Lite;
use Mojo::IOLoop;

my $send_to_controller;
my $send_to_video;

websocket '/messageToController' => sub {
	$send_to_video = shift;
	Mojo::IOLoop->stream($send_to_video->tx->connection)->timeout(300);
	$send_to_video->on(message => sub {
		my ($self, $msg) = @_;
		eval { $send_to_controller->send("$msg");};
	});
};

websocket '/messageToVideo' => sub {
	$send_to_controller = shift;
	Mojo::IOLoop->stream($send_to_controller->tx->connection)->timeout(300);
	$send_to_controller->on(message => sub {
		my ($self, $msg) = @_;
		eval {$send_to_video->send($msg);};
	});
};

app->start;