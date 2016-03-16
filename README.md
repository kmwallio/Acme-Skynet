# Skynet for Perl6

Skynet is a collection of AI for your Perls6.

## Intent

Attempts to determine your intended action from a command phrase.

``` perl6
use v6;
use Acme::Skynet::Intent;

my $robotOverlord = Intent.new();

my $time = sub {
    say now;
}

# Route commands to actions.
$robotOverlord.addKnowledge("what time is it", $time);
$robotOverlord.addKnowledge("current time", $time);

my $stab = sub ($who) {
    say "Stabbed $who";
}

# Basic support for commands with arguments
$robotOverlord.addKnowledge("stab john -> john", $stab);
$robotOverlord.addKnowledge("stuart deserves to be stabbed -> stuart", $stab);

# Perform some training and learning
$robotOverlord.meditate();

# Provide some input
$robotOverlord.hears("please stab carlos"); # Expected output: "Stabbed carlos"
$robotOverload.hears("what is the time"); # Expected output: the time
```

## What about the 3 laws of robotics?

Rules were made to be broken.

## TODO

* [ ] Write Skynet V1
* [ ] Add multiple layers of Machine Learning, supposed to make things better
* [ ] Convince everyone I know what I'm doing
* [ ] Acquire government funding and live it up
* [ ] Add in 3 laws of robotics
* [ ] Have no regrets
