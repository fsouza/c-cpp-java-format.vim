#!/usr/bin/env perl -w

# Copyright 2013 Francisco Souza. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

my @lines = <STDIN>;
my $source = join('', @lines);

my $filename = '/tmp/formatctmpfile21311.c';
open TMP, '>', $filename;
print TMP $source;
close(TMP);

system("astyle", $filename, "--style=kr", "--indent=tab", "--quiet", "--add-brackets", "--align-pointer=name", "--align-reference=name");
open TMP, $filename;
@lines = <TMP>;
close(TMP);

foreach (@lines) {
	$_ =~ s/^(\s*)([a-zA-Z0-9_\s]+\s?(\s|\*))([\w:]+)\s?(\(.*\)\n)$/$1$2\n$4$5/;
	$_ =~ s/^(\s*)((typedef )?)(struct.*|static struct|enum.*|union.*)\s{\n$/$1$2$4\n$1\{\n/g;
	$_ =~ s/([^\s])\s?\|\s?([^\s])/$1|$2/g;
	$_ =~ s/^(\s+)(#)/$2/;
	$_ =~ s/(for|if|while)\s+\(/$1(/g;
	$_ =~ s/\s+\n/\n/g;
}
$source = join('', @lines);
$source =~ s/(\n}(;|\s[a-zA-Z0-9-_]+;)?\n)([a-zA-Z])/$1\n$3/g;
print $source;
