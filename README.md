# Subtitle Separater

This is an experiment in splitting the video and subtitles onto two screens that communicate with each other using websockets.

## Requirements

* Perl 5.16
* Mojolicious
* Modern web browser with websocket and HTML5 video support

## Usage

* Edit `video.html` to point to the video file
* Edit `controller.html` to add JSON formatted subtitles of the form `{ 'start': ..., 'end': ...., 'text': ... }` 
* Start server: `morbo server.pl`
* Load `video.html` as a local file in a web browser
* Connect to `SERVER_IP_ADDRESS_/controller.html`

## Intention

The intention behind this is because my reading is a lot better than my listening and when watching something with subtitles, I usually end up just reading instead
of actually listening to the dialogue. By splitting the subtitles away from the video, I will  decrease the dependence on reading the subtitles in order to understand the audio and 
instead focus wholly on the audio itself and use the subtitles to only check my understanding. 

## Features

The intended use case is loading the video on some device with a large screen and accessing the video through the controller on a tablet. The controller can play and pause the video 
and will autoscroll and highlight the current line. While watching, when one needs to understand something, one will just glance down and look at the line and return to the screen

## Todo

* Rewrite to use WebRTC to remove the need for a server
* Play line by clicking it
* Define a range of lines to loop
* Mark lines for review and perhaps autoimport to Anki turning this into a precise Subs2SRS
