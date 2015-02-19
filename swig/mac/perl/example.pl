#!/usr/bin/perl

use PerlChatScript;
use Scalar::Util 'reftype';

my @argv = ("", "local", "trace");
my $argc = @argv ;
my $path = "../../../";


# my $chatscript = PerlChatScript::InitSystem($argc,@argv,$path,$path,$path);
# my $chatscript = PerlChatScript::InitSystem($argc,$path,$path,$path,$path);
my $chatscript = PerlChatScript::InitSystem($argc,\@argv,$path,$path,$path);

print "\nServer started..." . reftype(argv) . "\n";

my $userName = "Todd";
my $botName = "HARRY";
my $input = "hello";
my $ip = undef;

print "\nHello " . $userName . ". type :quit to quit\n\n".$userName.": ";

do {

$input = <>;

if ( $input =~ /^\:quit/ ) {exit 0;}

my $output = PerlChatScript::PerformChat($userName,$botName,$input,$ip);
print "Harry: " . $output . "\n".$userName.": ";;

} while ( 1 );
