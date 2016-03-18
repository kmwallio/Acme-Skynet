use v6;
use Acme::Skynet::DumbDown;
use Acme::Skynet::ChainLabel;
use Acme::Skynet::ID3;

=begin pod

=head1 NAME

Acme::Skynet

=head1 DESCRIPTION

Acme::Skynet provides the Intent class.  This acts as a router of string
commands to function calls.

=head2 Examples

=end pod

module Acme::Skynet {
  my $emptySub = sub {
  }

  class Thingy does Featurized {
    has $.phrase;
    has &.action;
    has @!dumbPhrase;
    has Bool $!built = False;
    has %!features;
    has $.command is rw;

    method new(Str $phrase, &action) {
      self.bless(:$phrase, :&action);
    }

    method build() {
      if ($!built) {
        return;
      }
      $!built = True;
      my @parts = $.phrase.split(/\s+'->'\s+/);
      $.command = @parts[0];
      @!dumbPhrase = extraDumbedDown($.command).split(/\s+/);
      for @!dumbPhrase -> $feature {
        %!features{$feature}++;
      }
    }

    method getFeature($feature) {
      self.build();
      return %!features{$feature}:exists;
    }

    method getFeatures() {
      self.build();
      return %!features.keys();
    }

    method getLabel() {
      return &.action.gist();
    }
  }

  class Intent is export {
    has ID3Tree $!classifier;
    has %!labels;
    has %!features;
    has %!router;
    has %!labelers{Any}; # One for each class
    has @!data;
    has Bool $!built = False;
    has Bool $!learned = False;

    method addKnowledge(Str $str, &route) {
      my $train = Thingy.new($str, &route);
      @!data.push($train);

      # Create the ID3Tree
      unless ($!built) {
        $!built = True;
        $!classifier = ID3Tree.new();
      }
      $!classifier.addItem($train);

      # Create a label
      %!labels{&route.gist()}++;
      %!router{&route.gist()} = &route;

      # Add words to list of features
      $train.getFeatures().map(-> $feat {
        %!features{$feat}++;
      });

      # Create a labeller if needed
      unless (%!labelers{&route.gist()}:exists) {
        %!labelers{&route.gist()} = ChainLabel.new();
      }

      %!labelers{&route.gist()}.add($train.phrase);
    }

    method meditate() {
      if ($!learned) {
        return;
      }

      $!learned = True;
      $!classifier.setLabels(%!labels.keys());
      $!classifier.setFeatures(%!features.keys());
      $!classifier.learn();

      for %!labelers.values -> $labeller {
        $labeller.learn();
      }
    }

    method hears(Str $whisper) {
      my $command = Thingy.new($whisper, $emptySub);
      my $action = $!classifier.get($command);
      my @args = %!labelers{$action}.get($command.phrase);
      my &route = %!router{$action};
      route(@args);
    }
  }
}
