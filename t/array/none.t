#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

ok( @numbers->none( sub { $_ < 0 } ) );
ok( not @numbers->none( sub { $_ > 5 } ) );

ok( @numbers->none(qr/^foo/) );
ok( !@numbers->none(qr/^1/) );

done_testing();
