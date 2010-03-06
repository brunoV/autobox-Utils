package autobox::Utils::Hash;
use strict;
use warnings;
require Carp;

sub flip {
    Carp::croak("Can't flip hash with references as values")
        if grep { ref } values %{$_[0]};

    my %flipped = reverse %{$_[0]};

    return wantarray ? %flipped : \%flipped;
}

sub merge {
    require Hash::Merge::Simple;
    my $merged = Hash::Merge::Simple::merge(@_);

    return wantarray ? %$merged : $merged;
}

=method flip()

Exchanges values for keys in a hash.

    my %things = ( foo => 1, bar => 2, baz => 5 );
    my %flipped = %things->flip; # { 1 => foo, 2 => bar, 5 => baz }

If there is more than one occurence of a certain value, any one of the
keys may end up as the value.  This is because of the random ordering
of hash keys.

    # Could be { 1 => foo }, { 1 => bar }, or { 1 => baz }
    { foo => 1, bar => 1, baz => 1 }->flip;

Because hash references cannot usefully be keys, it will not work on
nested hashes.

    { foo => [ 'bar', 'baz' ] }->flip; # dies

In list context, returns a list. In scalar context, returns a hash
reference.


=method merge

Recursively merge two or more hashes together using L<Hash::Merge::Simple>.

    my $a = { a => 1 };
    my $b = { b => 2, c => 3 };

    $a->merge($b); # { a => 1, b => 2, c => 3 }

For conflicting keys, rightmost precedence is used:

    my $a = { a => 1 };
    my $b = { a => 100, b => 2};

    $a->merge($b); # { a => 100, b => 2 }
    $b->merge($a); # { a => 1,   b => 2 }

It also works with nested hashes, although it won't attempt to merge
array references or objects.

In list context, returns a list. In scalar context, returns a hash
reference.

=cut

1;
