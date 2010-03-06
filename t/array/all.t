#!/usr/bin/env perl

use autobox::Utils;
use Test::More;

my @numbers = ( 1 .. 10 );

ok( @numbers->all( sub { $_ < 100 } ) );
ok( not ( @numbers->all( sub { $_ > 100 } )  ) );

ok( @numbers->all(qr/\d+/) );
ok( !@numbers->all(qr/^1/) );

done_testing();
