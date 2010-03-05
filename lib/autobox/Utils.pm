package autobox::Utils;

use parent 'autobox';

require autobox::Utils::ARRAY;

sub import {
    my $class = shift;
    $class->autobox::import(
        DEFAULT  => 'autobox::Utils::',
#        SCALAR => 'autobox::Utils::SCALAR',
#        HASH   => 'autobox::Utils::HASH',
    );
}

1;
