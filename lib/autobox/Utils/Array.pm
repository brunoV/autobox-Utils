package autobox::Utils::Array;

# ABSTRACT: Autoboxed methods for scalars

use strict;
use warnings;
require Carp;

sub all {
    require List::MoreUtils;

    my $filter = $_[1];

    if (ref $filter eq 'Regexp') {
        return List::MoreUtils::all( sub { $_ =~ $filter }, @{$_[0]} );
    }

    return List::MoreUtils::all($_[1], @{$_[0]});
}

sub any {
    require List::MoreUtils;

    my $filter = $_[1];

    if (ref $filter eq 'Regexp') {
        return List::MoreUtils::any( sub { $_ =~ $filter }, @{$_[0]} );
    }

    return List::MoreUtils::any($_[1], @{$_[0]});
}

sub none {
    require List::MoreUtils;

    my $filter = $_[1];

    if (ref $filter eq 'Regexp') {
        return List::MoreUtils::none( sub { $_ =~ $filter }, @{$_[0]} );
    }

    return List::MoreUtils::none($_[1], @{$_[0]});
}

sub true {
    require List::MoreUtils;

    my $filter = $_[1];

    if (ref $filter eq 'Regexp') {
        return List::MoreUtils::true( sub { $_ =~ $filter }, @{$_[0]} );
    }

    return List::MoreUtils::true($_[1], @{$_[0]});
}

sub false {
    require List::MoreUtils;

    my $filter = $_[1];

    if (ref $filter eq 'Regexp') {
        return List::MoreUtils::false( sub { $_ =~ $filter }, @{$_[0]} );
    }

    return List::MoreUtils::false($_[1], @{$_[0]});
}

sub uniq {
    require List::MoreUtils;
    my @uniq = List::MoreUtils::uniq(@{$_[0]});
    return wantarray ? @uniq : \@uniq;
}

sub minmax {
    require List::MoreUtils;
    my @minmax = List::MoreUtils::minmax(@{$_[0]});
    return wantarray ? @minmax : \@minmax;
}

sub mesh {
    require List::MoreUtils;
    my @mesh = List::MoreUtils::zip(@_);
    return wantarray ? @mesh : \@mesh;
}

sub head {
    return $_[0]->[0];
}

sub slice {
    my $list = shift;
    # the rest of the arguments in @_ are the indices to take

    return wantarray ? @$list[@_] : [@{$list}[@_]];
}

sub range {
    my ($array, $lower, $upper) = @_;

    my @slice = @{$array}[$lower .. $upper];

    return wantarray ? @slice : \@slice;

}

sub tail {

    my $last = $#{$_[0]};

    my $first = defined $_[1] ? $last - $_[1] + 1 : 1;

    Carp::croak("Not enough elements in array") if $first < 0;

    # Yeah... avert your eyes
    return wantarray ? @{$_[0]}[$first .. $last] : [@{$_[0]}[$first .. $last]];
}

=method all

    @list->all($regex);
    @list->all($code);

Returns true if all items in C<@list> match C<$regex> or make C<$code>
return true.

=method any

    @list->any($regex);
    @list->any($code);

Returns true if any item in C<@list> matches C<$regex> or makes C<$code>
return true.

=method none

    @list->none($regex);
    @list->none($code);

Returns true if none of the items in C<@list> match C<$regex> or make
C<$code> return true.

=method true

    @list->true($regex);
    @list->true($code);

Returns the number of elements in C<@list> that match C<$regex> or make
C<$code> return true.

=method false

    @list->false($regex);
    @list->false($code);

Returns the number of elements in C<@list> that don't match C<$regex> or
make C<$code> return false.

=method uniq

    my @uniq = @list->uniq;

Returns a new list stripping duplicate elements from C<@list>. In scalar
context, returns an array reference to allow further calls.

=method minmax

    my @minmax = @list->minmax;

Returns a 2-element list with the minimum and maximum values from
C<@list>.  In scalar context returns an array reference.


=method mesh

    my @names = qw(Barry Larry Mary);
    my @ages  = (24, 42, 55);

    my %friends = @names->mesh(\@ages);
    # { Barry => 24, Larry => 42, Mary => 55 }

Returns a list intertwining the elements of the arrays given as
argument. It can be called with any number of arrays. In scalar context
returns an array reference.

=method head

    my $first = @list->head;

Returns the first element from C<@list>.

=method tail

    my @list = qw(foo bar baz quux);
    my @rest = @list->tail;  # [ 'bar', 'baz', 'quux' ]

Returns all but the first element from C<@list>. In scalar context
returns an array reference.

Optionally, you can pass number as argument to ask for the last C<$n>
elements:

    @rest = @list->tail(2); # [ 'baz', 'quux' ]

=method slice

    my @sublist = @list->slice(@indexes);

Returns a list containing the elements from C<@list> at the indices
C<@indices>. In scalar context, returns an array reference.

=method range

    my @sublist = @list->range( $lower_idx, $upper_idx );

Returns a list containing the elements from C<@list> with indices
ranging from C<$lower_idx> to C<$upper_idx>. Returns an array reference
in scalar context.

=cut

1;
