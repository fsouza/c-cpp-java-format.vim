#!/usr/bin/env perl -w

my @lines = <STDIN>;
my $source = join('', @lines);

my $filename = '/tmp/formatctmpfile21311.java';
open TMP, '>', $filename;
print TMP $source;
close(TMP);

system("astyle", $filename, "--style=java", "--indent=tab", "--quiet");
open TMP, $filename;
@lines = <TMP>;
close(TMP);
$source = join('', @lines);
print $source;
