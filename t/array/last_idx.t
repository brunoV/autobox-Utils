#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

is( @numbers->last_idx, 9 );
is( @numbers->last_idx( sub { $_ > 2 } ), 9 );

is( @numbers->last_idx( qr/^1/ ), 9 );

done_testing();
