# Skynet for Perl6

Skynet is a collection of AI for your Perls6.

## Intent

Attempts to determine your intended action from a command phrase.

``` perl6
use v6;
use Acme::Skynet::Intent;

my $robotOverlord = Intent.new();

my $time = sub {
    say now
}

$robotOverlord.addAction("what time is it", $time);
$robotOverlord.addAction("current time", $time);

my $stab = sub ($who) {
    say "Stabbed $who";
}

$robotOverlord.addAction("stab john -> john", $stab);
$robotOverlord.addAction("stuart deserves to be stabbed -> stuart", $stab);


```
