#!/bin/bash

# Copyright 2013 Francisco Souza. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

expected="#include <stdio.h>
#include <stdlib.h>

struct Person
{
	char *name;
	int  age;
};

typedef struct Person Person;

typedef struct
{
	char *name;
} car;

int
doSomething(char *name)
{
	return 1;
}

int
main(void)
{
	union
	{
		int d;
		char f;
	};
	d = 4;
	int i;
	for(i = 0; i < 0; i++) {
		printf(\"%d\", i);
	}
	return 0;
}"

got=`bin/format-c.pl <<END
#include <stdio.h>
#include <stdlib.h>

struct Person {
	char *name;
	int  age;
};

typedef struct Person Person;

typedef struct {
	char *name;
} car;

int doSomething(char * name){
	return 1;
}

int main(void) {
	union {
		int d;
		char f;
	};
    d = 4;
	int i;
	for (i = 0; i < 0; i++)
	  printf("%d", i);
	return 0;
}
END`

if [ "$got" != "$expected" ]
then
	echo "ERROR: unexpected output."
	diff <(echo "$expected") <(echo "$got")
	echo
	exit 1
fi
