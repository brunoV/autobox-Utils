#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use autobox::Utils;

my @array = qw(foo bar baz);

ok @array->head;
is @array->head, 'foo';

is_deeply [@array->head(2)], ['foo', 'bar'], "head with argument";

my @head = @array->head(2);

is scalar @head, 2, "Returns a list in list context";

my $head = @array->head(2);

is ref $head, 'ARRAY', "Returns an arrayref in scalar context";

done_testing();
