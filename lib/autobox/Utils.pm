package autobox::Utils;

use parent 'autobox';

require autobox::Utils::ARRAY;
require autobox::Utils::SCALAR;
require autobox::Utils::UNIVERSAL;

sub import {
    my $class = shift;
    $class->autobox::import(
        DEFAULT  => 'autobox::Utils::',
#        ARRAY   => 'autobox::Utils::ARRAY',
#        SCALAR  => 'autobox::Utils::SCALAR',
        UNIVERSAL => 'autobox::Utils::UNIVERSAL',
#        HASH   => 'autobox::Utils::HASH',
    );
}

1;
