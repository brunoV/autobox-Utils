#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

is( @numbers->first_idx, 0 );
is( @numbers->first_idx( sub { $_ > 9 } ), 9 );

is( @numbers->first_idx( qr/^2/ ), 1 );

done_testing();
