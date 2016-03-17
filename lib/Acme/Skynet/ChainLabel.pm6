use v6;
use Acme::Skynet::DumbDown;
=begin pod

=head1 NAME

Acme::Skynet::ChainLabel

=head1 DESCRIPTION

Acme::Skynet::ChainLabel attempts to find arguments from a given
phrase.

For example, if say "Remind me at 7 to strech", it could correspond
to a function call remindMe(7, "stretch").  Given a series of inputs,
we try to come up with a graph to handle various inputs.

ChainLabel is a very basic.  If you use certain cue words multiple
times, it can mess up the labeling.  ChainLabel will be used as a
preprocessor in the future.

=head2 Examples

    use Acme::Skynet::ChainLabel;

    my $reminders = ChainLabel.new;
    $reminders.add("remind me at 7 to strech -> 7, strech");
    $reminders.add("at 6 pm remind me to shower -> 6 pm, shower");
    $reminders.add("remind me to take out the chicken in 15 minutes -> 15 minutes, take out the chicken");
    $reminders.learn();

    my @args = $reminders.get("remind me in 10 minutes to e-mail jim"); # (10 minutes, e-mail jim)

=end pod

module Acme::Skynet::ChainLabel {
  class Node {
    has Str @.entry;
    has Bool $!visited;

    method collect(Str $word) {
      @.entry.push($word);
    }

    method reset() {
      @.entry = ();
      $!visited = False;
    }

    method gist() {
      @.entry.join(' ');
    }

    method isEmpty() {
      (@.entry.elems() == 0);
    }
  }

  class ChainLabel is export {
    has @!commands;
    has $!args;
    has %!nodes;
    has %!paths;

    method add(Str $command) {
      @!commands.push($command);
    }

    method learn() {
      my @simpleCommands;

      # Remove arguments from phrase and replace with tokens
      for @!commands -> $command {
        my ($phrase, @action) = $command.split(/\s*('->'|',')\s*/);
        $!args = @action.elems();
        my $arg = 0;
        for @action -> $values {
          $phrase ~~ s:i/$values/ARG:$arg/;
          $arg++;
        }
        @simpleCommands.push(extraDumbedDown($phrase));
      }

      # Generate a graph based on the phrases
      %!nodes{'.'} = Node.new();
      for @simpleCommands -> $command {
        my $previousWord = '.';
        for $command.split(/\s+/) -> $word {
          %!nodes{$word} = Node.new();
          %!paths.push: ($previousWord => $word);
          $previousWord = $word;
        }
      }
    }

    method get(Str $phrase) {
      # Reset node states
      for %!nodes.values -> $node {
        $node.reset();
      }

      # Traverse the graph
      my $position = '.';
      my @command = extraDumbedDown($phrase).split(/\s+/);
      for @command -> $nextPosition {
        $position = $nextPosition;
      }
    }
  }
}
