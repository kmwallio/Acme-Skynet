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

## Chain Labelling

Does labeling have 1 l or 2?  Spell check okays both... this is how it all starts...

You need a classifier in front of this.  If you run a completely unrelated phrase through the labeler, your results will be completely unrelated.  That's unexpected.

``` perl6
use v6;
use Acme::Skynet::ChainLabel;

# Create a new labeler
my $reminders = ChainLabel.new();

# Tell it some facts
$reminders.add("remind me at 7 to strech -> 7, strech");
$reminders.add("at 6 pm remind me to shower -> 6 pm, shower");
$reminders.add("remind me to run at the robot apocalypse -> the robot apocalypse, run");

# Let it learn those facts.
$reminders.learn();

my @ret = $reminders.get("at 6 pm remind me to let's shower");
say @ret[0]; # => "6 pm"
say @ret[1]; # => "let's shower"

@ret = $reminders.get("remind me to feed my cats at lunch time");
say @ret[0]; # => "lunch time", "Got time";
say @ret[1]; # => "feed my cats", "Got original plural phrase";
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
