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

  class ID3Tree is export {
    my @!trainingSet;
    my ID3Tree @!children;
    my @!values;
    my @!features;
    my @!labels;
    my $!feature;
    my $!label;

    method addItem(Featurized $item) {
      @!trainingSet.push($item);
    }

    method setFeatures(@features) {
      @!features = @features;
    }

    method setLabels(@labels) {
      @!labels = @labels;
    }

    method learn() {
      if (@!children.elems() != 0 || $!label) {
        return;
      }
    }

    method get(Featurized $item) {
      if ($!label) {
        return $!label;
      }

      for [0..(@!values-1)] -> $i {
        if (@!values[$i] eq $item.getFeature($!feature)) {
          return @!children[$i].get($item);
        }
      }

      return Nil;
    }
  }
}
