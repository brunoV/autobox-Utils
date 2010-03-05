package autobox::Utils::Scalar;
require Carp;
use strict;
use warnings;

sub title_case {
    my ($string) = @_;
    $string =~ s/\b(\w)/\U$1/g;
    return $string;
}

sub center {
    my ($string, $size, $char) = @_;
    Carp::carp("Use of uninitialized value for size in center()") if !defined $size;
    $size //= 0;
    $char //= ' ';

    if (length $char > 1) {
        my $bad = $char;
        $char = substr $char, 0, 1;
        Carp::carp("'$bad' is longer than one character, using '$char' instead");
    }

    my $len             = length $string;

    return $string if $size <= $len;

    my $padlen          = $size - $len;

    # pad right with half the remaining characters
    my $rpad            = int( $padlen / 2 );

    # bias the left padding to one more space, if $size - $len is odd
    my $lpad            = $padlen - $rpad;

    return $char x $lpad . $string . $char x $rpad;
}

sub ltrim {
    my ($string,$trim_charset) = @_;
    $trim_charset = '\s' unless defined $trim_charset;
    my $re = qr/^[$trim_charset]*/;
    $string =~ s/$re//;
    return $string;
}

sub rtrim {
    my ($string,$trim_charset) = @_;
    $trim_charset = '\s' unless defined $trim_charset;
    my $re = qr/[$trim_charset]*$/;
    $string =~ s/$re//;
    return $string;
}

sub trim {
    my $charset = $_[1];

    return rtrim(ltrim($_[0], $charset), $charset);
}

sub wrap {
    my ($string, %args) = @_;

    my $width     = $args{width}     // 76;
    my $separator = $args{separator} // "\n";

    return $string if $width <= 0;

    require Text::Wrap;
    local $Text::Wrap::separator = $separator;
    local $Text::Wrap::columns   = $width;

    return Text::Wrap::wrap('', '', $string);

}

require POSIX;
*ceil  = \&POSIX::ceil;
*floor = \&POSIX::floor;
*round_up   = \&ceil;
*round_down = \&floor;
sub round {
    abs($_[0] - int($_[0])) < 0.5 ? round_down($_[0])
                                  : round_up($_[0])
}

require Scalar::Util;
*is_number = \&Scalar::Util::looks_like_number;
sub is_positive         { is_number($_[0]) && $_[0] > 0 }
sub is_negative         { is_number($_[0]) && $_[0] < 0 }
sub is_integer          { is_number($_[0]) && ((int($_[0]) - $_[0]) == 0) }
*is_int = \&is_integer;
sub is_decimal          { is_number($_[0]) && ((int($_[0]) - $_[0]) != 0) }


1;
