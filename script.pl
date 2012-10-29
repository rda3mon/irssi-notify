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
my $last_call = 0;

######################################################
sub notify_user {
	my ($server, $channel, $sender, $msg) = @_;

	my $command = "notify-send -i ~/.irssi/scripts/images/irssi.png Irssi::$channel \"$sender - $msg\"";
	system($command);

	my $time = timelocal(




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

	for my $nick (@nicks) {
		return if ($nick eq $sender);
	}
	notify_user($server, $channel, $sender, $msg);
}

	
Irssi::signal_add('print text', \&handle_print_text);



##################################################################33

#Irssi::command_bind test => \&test;
#sub test {
#	my $file;
#	open($file, '>>/home/mallikarjun/testing');
#	print $file 'hello\n';
#	close($file);
#
#	my ($data, $server, $witem) = @_;
#	return unless $witem;
#	$witem->print('It Works!');
#}


