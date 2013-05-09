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

system("astyle", $filename, "--indent-namespaces", "--style=bsd", "--quiet", "--add-brackets");

open TMP, $filename;
@lines = <TMP>;
close(TMP);
print join("", @lines);
