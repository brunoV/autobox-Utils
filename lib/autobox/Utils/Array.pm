package autobox::Utils::Array;
use strict;
use warnings;
require Carp;

sub all {
    require List::MoreUtils;
    return List::MoreUtils::all($_[1], @{$_[0]});
}

sub any {
    require List::MoreUtils;
    return List::MoreUtils::any($_[1], @{$_[0]});
}

sub none {
    require List::MoreUtils;
    return List::MoreUtils::none($_[1], @{$_[0]});
}

sub true {
    require List::MoreUtils;
    return List::MoreUtils::true($_[1], @{$_[0]});
}

sub false {
    require List::MoreUtils;
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

1;