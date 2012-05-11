#!/usr/bin/env perl -w

my @lines = <STDIN>;
my $source = join('', @lines);

my $filename = '/tmp/formatctmpfile21311.c';
open TMP, '>', $filename;
print TMP $source;
close(TMP);

system("indent", $filename);
open TMP, $filename;
@lines = <TMP>;
close(TMP);

$source = join('', @lines);
$source =~ s/(\s)+$//gm;
$source =~ s/(\n}\n)([a-z])/$1\n$2/g;
print $source;
