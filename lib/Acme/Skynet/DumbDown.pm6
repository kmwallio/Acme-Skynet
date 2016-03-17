use v6;
use Lingua::EN::Stem::Porter;
=begin pod

=head1 NAME

=head1 DESCRIPTION

Acme::Skynet::DumbDown converts a word or sentence into an easier to
understand format.  It remove plurals and attempts to identify the
root of a word.

=head2 Examples

    use Acme::Skynet::DumbDown;

    # Single world
    say dumber('cats'); # => cat

    # Sentence
    say dumber('he eats cats'); # => 'he eat cat'

=head2 ACKNOWLEDGEMENTS

Acme::Skynet::DumbDown is currently a wrapper around
Lingua::EN::Stem::Porter adding support for sentences.

=end pod

module Acme::Skynet::DumbDown {
  sub dumber($phrase) is export {
    $phrase.split(/\s+/).map({ porter($^word) }).join(' ');
  }

  sub dumbdown($phrase) is export {
    dumber($phrase);
  }
}
