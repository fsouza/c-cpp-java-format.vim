#!/usr/bin/env perl -w

my @lines = <STDIN>;
my $source = join('', @lines);

my $filename = '/tmp/formatctmpfile21311.c';
open TMP, '>', $filename;
print TMP $source;
close(TMP);

system("indent", $filename);
system("indent", $filename);
system("rm", "-f", "formatctmpfile21311.c.BAK");
open TMP, $filename;
@lines = <TMP>;
close(TMP);

$source = join('', @lines);
$source =~ s/(struct.*)\s{\n/$1\n{\n/g;
$source =~ s/(\n};?\n)([a-z])/$1\n$2/g;
$source =~ s/([^\s])\s?\|\s?([^\s])/$1|$2/g;
print $source;
