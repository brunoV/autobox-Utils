package autobox::Utils;
use strict;
use warnings;

use parent 'autobox';

require autobox::Utils::Array;
require autobox::Utils::Scalar;
require autobox::Utils::Universal;

sub import {
    my $class = shift;
    $class->autobox::import(
        ARRAY     => 'autobox::Utils::Array',
        SCALAR    => 'autobox::Utils::Scalar',
        UNIVERSAL => 'autobox::Utils::Universal',
    );
}

1;
