#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use autobox::Utils;

my @array = qw(foo bar baz);

ok @array->tail;
is_deeply [@array->tail], ['bar', 'baz'];

my @tail = @array->tail;

is scalar @tail, 2, "Returns a list in list context";

my $tail = @array->tail;

is ref $tail, 'ARRAY', "Returns an arrayref in scalar context";

done_testing();
