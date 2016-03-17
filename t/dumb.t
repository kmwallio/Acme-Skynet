use v6;
use lib 'lib';
use Test;
use Acme::Skynet::DumbDown;

plan 4;

# Test one plural word
ok dumbdown("cats") eq "cat";

# Phrase
ok dumber("the kids have cats") eq "the kid have cat";

# Multi-Level Dumbing Down
ok dumbdown("computers") eq "comput";

# Example
ok dumber('he eats cats') eq "he eat cat";
