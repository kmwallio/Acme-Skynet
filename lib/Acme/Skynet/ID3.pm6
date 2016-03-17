use v6;
=begin pod

=head1 NAME

Acme::Skynet::ID3

=head1 DESCRIPTION

Acme::Skynet::ID3 is a basic implementation for generating an ID3 tree.

=head2 Examples

    use Acme::Skynet::ID3;



=end pod

module Acme::Skynet::ID3 {
  role Featurized {
    method getFeature($feature) {
      die("Overwrite this method in your class");
    }

    method getLabel() {
      die("Overwrite this method in your class");
    }
  }

  class ID3Tree {
    my @!trainingSet;
    my ID3Tree @!children;

    method addItem(Featurized $item) {
      @!trainingSet.push($item);
    }
  }
}
