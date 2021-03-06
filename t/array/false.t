#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

is( @numbers->false( sub { $_ < 5 } ), 6 );
is( @numbers->false( sub { $_ > 9 } ), 9 );

is( @numbers->false(qr/foo/), 10 );

done_testing();
