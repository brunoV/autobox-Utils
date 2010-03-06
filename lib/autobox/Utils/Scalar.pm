package autobox::Utils::Scalar;

# ABSTRACT: Autoboxed methods for scalars

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

=method title_case

    my $name = 'joe smith'->title_case;   # Joe Smith

Will uppercase every word character that follows a wordbreak character.

=method center()

    my $centered_string = $string->center($length);
    my $centered_string = $string->center($length, $character);

Centers $string between $character.  $centered_string will be of
length $length.

C<$character> defaults to " ".

    say "Hello"->center(10);        # "   Hello  ";
    say "Hello"->center(10, '-');   # "---Hello--";

C<center()> will never truncate C<$string>.  If $length is less
than C<< $string->length >> it will just return C<$string>.

    say "Hello"->center(4);        # "Hello";

=method trim

    my $trimmed = $string->trim;
    my $trimmed = $string->trim($character_set);

Trim whitespace.  ltrim() trims off the start of the string (left),
rtrim() off the end (right) and trim() off both the start and end.

    my $string = '    testme'->ltrim;        # 'testme'
    my $string = 'testme    '->rtrim;        # 'testme'
    my $string = '    testme    '->trim;     # 'testme'

They all take an optional $character_set which will determine what
characters should be trimmed.  It follows regex character set syntax
so C<A-Z> will trim everything from A to Z.  Defaults to C<\s>,
whitespace.

    my $string = '-> test <-'->trim('-><');  # ' test '

=method ltrim

=method rtrim

=method wrap

    my $wrapped = $string->wrap( width => $cols, separator => $sep );

Wraps $string to width $cols, breaking lines at word boundries using
separator $sep.

If no width is given, $cols defaults to 76. Default line separator is
the newline character "\n".

See L<Text::Wrap> for details.

=method round

    my $rounded_number = $number->round;

Round to the nearest integer.

=method round_up

=method ceil

    my $new_number = $number->round_up;

Rounds the $number up.

    2.45->round_up;  # 3

ceil() is a synonym for round_up().


=method round_down

=method floor

    my $new_number = $number->round_down;

Rounds the $number down.

    2.45->round_down; # 2

floor() is a synonyn for round_down().

=method is_number

    $is_a_number = $thing->is_number;

Returns true if $thing is a number understood by Perl.

    12.34->is_number;           # true
    "12.34"->is_number;         # also true
    "eleven"->is_number;        # false

=method is_positive

    $is_positive = $thing->is_positive;

Returns true if $thing is a positive number.

0 is not positive.

=method is_negative

    $is_negative = $thing->is_negative;

Returns true if $thing is a negative number.

0 is not negative.

=method is_integer

    $is_an_integer = $thing->is_integer;

Returns true if $thing is an integer.

    12->is_integer;             # true
    12.34->is_integer;          # false
    "eleven"->is_integer;       # false

=method is_int

A synonym for is_integer

=method is_decimal

    $is_a_decimal_number = $thing->is_decimal;

Returns true if $thing is a decimal number.

    12->is_decimal;             # false
    12.34->is_decimal;          # true
    ".34"->is_decimal;          # true
    "point five"->is_decimal;   # false

=cut

1;
