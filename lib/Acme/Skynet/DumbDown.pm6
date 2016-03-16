use v6;
=begin pod
  Acme::Skynet::DumbDown converts a word or sentence into an easier to
  understand format.  It remove plurals and attempts to identify the
  root of a word.
    use Acme::Skynet::DumbDown;

    # Single world
    say dumber('cats'); # => cat

    # Sentence
    say dumber('he eats cats'); # => 'he eat cat'
=end pod

module Acme::Skynet::DumbDown {

}
