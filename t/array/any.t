#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

ok( @numbers->any( sub { $_ < 5 } ) );
ok( not ( @numbers->any( sub { $_ > 100 } )  ) );

ok( @numbers->any(qr/^1/) );
ok( !@numbers->any(qr/foo/) );

done_testing();
