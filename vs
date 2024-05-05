#! /usr/bin/perl
#
# vs
#
# view source (and open it for editing)

use v5.24;
use experimental qw<signatures>;

use File::Which qw<which>;


my ($cmd) = shift or error(101, "No command supplied");
error(102, "Too many arguments") if @ARGV;

my $path = which $cmd;
error(103, "Command '$cmd' not found in \$PATH") if !defined $path;

error(201, "$path is not a text file") if !-T $path;
exec 'sensible-editor', $path;


sub error($code, $msg)
{
  my $cmd = $0 =~ s#.*/##r;
  warn "$cmd: $msg\n";
  exit $code;
}
