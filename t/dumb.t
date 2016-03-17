use v6;
use lib 'lib';
use Test;
use Acme::Skynet::DumbDown;

plan 8;
# Test one plural word
ok dumbdown("cats") eq "cat";

# Phrase
ok dumber("the kids have cats") eq "the kid have cat";

# Multi-Level Dumbing Down
ok dumbdown("computers") eq "comput";

# Example
ok dumber('he eats cats') eq "he eat cat";

# Decontracted
ok extraDumbedDown("we're so cool") eq "we ar so cool";
ok extraDumbedDown("what's the current o'clock") eq "what is the current of the clock";

# Labeled
ok labeledDumbdown("he eats cats").elems == 2;
ok labeledExtraDumbedDown("we're so cool").elems == 2;
