package autobox::Utils;

# ABSTRACT: Additional autoboxed methods for native Perl data types

use strict;
use warnings;

use parent 'autobox';

require autobox::Utils::Array;
require autobox::Utils::Scalar;
require autobox::Utils::Hash;
require autobox::Utils::Universal;

sub import {
    my $class = shift;
    $class->autobox::import(
        ARRAY     => 'autobox::Utils::Array',
        HASH      => 'autobox::Utils::Hash',
        SCALAR    => 'autobox::Utils::Scalar',
        UNIVERSAL => 'autobox::Utils::Universal',
    );
}

=head1 SYNOPSIS

    use autobox::Utils;

    my @family = qw(Homer Marge Bart Lisa Maggie);

    my ($chief, @rest) = (@family->head, @family->tail);

    # $chief: 'Homer'
    # @rest: ['Marge', 'Bart', 'Lisa', 'Maggie'];

    my $salary = "too low";
    if ( $salary->is_number and $salary > 40_000 ) { say "yay!" }

    my $book_title = " how to be a klutz and still get published      ";

    say $book_title->trim->title_case;
    # "How To Be A Klutz And Still Get Published"

    ... and more.

=head1 DESCRIPTION

L<autobox::Utils> provides useful methods to native Perl data types. Its
goal is to complement L<autobox::Core> and L<autobox::List::Util> with
methods that are frequently desired but can't be found there.

=cut

1;
