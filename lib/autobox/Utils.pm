package autobox::Utils;
use strict;
use warnings;

use parent 'autobox';

require autobox::Utils::ARRAY;
require autobox::Utils::SCALAR;
require autobox::Utils::UNIVERSAL;

sub import {
    my $class = shift;
    $class->autobox::import(
        DEFAULT  => 'autobox::Utils::',
        UNIVERSAL => 'autobox::Utils::UNIVERSAL',
    );
}

1;
