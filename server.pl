#!perl
use v5.16;
use warnings;

=pod
=head1 DESCRIPTION

This mediates the interaction between the video and the controller by connecting websocket connections between them

=cut

use Mojolicious::Lite;
use Mojo::IOLoop;

my $send_to_controller;
my $send_to_video;

websocket '/messageToController' => sub {
	$send_to_video = shift;
	Mojo::IOLoop->stream($send_to_video->tx->connection)->timeout(3600);
	$send_to_video->on(message => sub {
		my ($self, $msg) = @_;
		eval { $send_to_controller->send("$msg");};
	});
};

websocket '/messageToVideo' => sub {
	$send_to_controller = shift;
	Mojo::IOLoop->stream($send_to_controller->tx->connection)->timeout(3600);
	$send_to_controller->on(message => sub {
		my ($self, $msg) = @_;
		eval {$send_to_video->send($msg);};
	});
};

app->start;
