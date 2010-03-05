#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use autobox::Utils;

my @array = qw(foo bar baz);

ok @array->tail;
is_deeply [@array->tail], ['bar', 'baz'];

is_deeply [@array->tail(1)], ['baz'];
is_deeply [@array->tail(2)], ['bar', 'baz'];
is_deeply [@array->tail(3)], ['foo', 'bar', 'baz'];

throws_ok { @array->tail(4) } qr/^Not enough elements/;

my @tail = @array->tail;
is scalar @tail, 2, "Returns a list in list context";

my $tail = @array->tail;
is ref $tail, 'ARRAY', "Returns an arrayref in scalar context";

done_testing();
