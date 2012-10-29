#!/usr/bin/perl

use strict;
use warnings;
use vars qw($VERSION %IRSSI);

use Irssi;
use Irssi::Irc;
use Irssi::TextUI;

use Data::Dumper;
use Time::Local;

$VERSION = '1.0.0';
%IRSSI  = (
	authors				=> 'Mallikarjun',
	contact				=> 'arjun@rdaemon.com',
	name					=> 'irssi-notify',
	description		=> 'Ubuntu notifications'.
										' for irssi',
	license				=> 'BSD',
	url						=> 'http://www.google.com',
	changed				=> 'Wed Oct 31 2012',
);

my $NAME = $IRSSI{name};

# Add your nicks here
my $last_sent = 0;

######################################################
sub notify_user {
	my ($server, $channel, $sender, $msg) = @_;

	my $command = "notify-send -i ~/.irssi/scripts/images/irssi.png Irssi::$channel \"$sender - $msg\"";

	my $now = time();
	if(($now - $last_sent) > 30){
		system($command);
		$last_sent = $now;
	}
}

sub handle_print_text {
	my ($dest, $text, $stripped) = @_;
	my $server = $dest->{server};

	return if(!$server || !($dest->{level} & MSGLEVEL_PUBLIC));

	my $msg_info = $stripped;
	my $sender = $msg_info;
	my $msg = $msg_info;
	my $channel = $dest->{target};

	$channel =~ s/^#//;
	$sender =~ s/^<.//;
	$sender =~ s/>[\s\t].*//;
	$msg =~ s/^<.[\w]+>[\s\t]//;
	$msg = substr($msg, 0, 10);

	return if ($sender eq $server->{nick});
	notify_user($server, $channel, $sender, $msg);
}

	
Irssi::signal_add('print text', \&handle_print_text);
