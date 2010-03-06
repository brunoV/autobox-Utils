#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

is( @numbers->true( sub { $_ < 5 } ), 4 );
is( @numbers->true( sub { $_ > 9 } ), 1 );

is( @numbers->true(qr/^1/), 2 );

done_testing();
