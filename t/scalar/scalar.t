#!/usr/bin/env perl

use Test::More 'no_plan';
use autobox::Utils;

is( "this is a test"->title_case, 'This Is A Test');
is( lc("this is a test")->title_case, 'This Is A Test');

is( "thIS is a teST"->title_case, 'ThIS Is A TeST');
is( lc("thIS is a teST")->title_case, 'This Is A Test');

is( '    testme'->ltrim, 'testme' );
is( '    testme'->rtrim, '    testme' );
is( '    testme'->trim,  'testme' );

is( 'testme    '->ltrim, 'testme    ' );
is( 'testme    '->rtrim, 'testme' );
is( 'testme    '->trim,  'testme' );

is( '    testme    '->ltrim, 'testme    ' );
is( '    testme    '->rtrim, '    testme' );
is( '    testme    '->trim,  'testme' );

is( '--> testme <--'->ltrim("-><"), ' testme <--' );
is( '--> testme <--'->rtrim("-><"), '--> testme ' );
is( '--> testme <--'->trim("-><"),  ' testme ' );

is( ' --> testme <--'->trim("-><"),  ' --> testme ' );
