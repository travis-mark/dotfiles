#!/usr/bin/perl
use File::Copy qw(move);
use File::Basename;

my $path;

while ($path = shift) {
    my($filename, $dirs, $suffix) = fileparse($path);
    my @d = localtime ((stat($path))[9]); 
    my $year = sprintf "%04s", $d[5]+1900;
    my $month = sprintf "%02s", $d[4]+1;
    my $day = sprintf "%02s", $d[3];
    $target = $dirs . $year . "-" . $month . "-" . $day . "-" . $filename . $suffix;
    move $path, $target;
}
