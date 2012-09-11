#!/usr/bin/env perl -w

my @lines = <STDIN>;
my $source = join('', @lines);

my $filename = '/tmp/formatctmpfile21311.c';
open TMP, '>', $filename;
print TMP $source;
close(TMP);

system("astyle", $filename, "--style=kr", "--indent=tab", "--quiet");
open TMP, $filename;
@lines = <TMP>;
close(TMP);

foreach (@lines) {
    $_ =~ s/^(\s*)([\w]+\s?\*?)\s([\w]+)\s?(\(.*\)\n)$/$1$2\n$3$4/;
    $_ =~ s/^(\s*)(struct.*|enum.*)\s{\n$/$1$2\n$1\{\n/g;
    $_ =~ s/([^\s])\s?\|\s?([^\s])/$1|$2/g;
    $_ =~ s/(for|if|while)\s+\(/$1(/g;
}
$source = join('', @lines);
$source =~ s/(\n};?\n)([a-z])/$1\n$2/g;
print $source;
