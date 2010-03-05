package autobox::Utils::ARRAY;

use Sub::Exporter -setup => {
    exports => [qw(first grep all any none true false uniq minmax mesh)],
    groups  => { default => [qw(:all)] }
};

sub first {
    my ( $array, $filter ) = @_;

    # Deep recursion and segfault (lines 90 and 91 in first.t) if we use
    # the same elegant approach as in grep().
    if ( ref $filter eq 'Regexp' ) {
        return List::Util::first( sub { $_ ~~ $filter }, @$array );
    }

    return List::Util::first( sub { $filter->() }, @$array );

}

sub grep {
    my ( $array, $filter ) = @_;

    my @result = CORE::grep { $_ ~~ $filter } @$array;

    return wantarray ? @result : \@result;
}

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

1;
