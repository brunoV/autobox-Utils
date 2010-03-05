#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use autobox::Utils;

my @array = qw(foo bar baz);

ok @array->head;
is @array->head, 'foo';

done_testing();
