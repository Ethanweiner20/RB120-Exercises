# Highest and Lowest Ranking Cards

=begin

Problem:
- Design the `Card` class such that the min/max of an array of `Card` objects
can be found using `Enumerable#min`
- Create a `Card#to_s` method

Ideas:
- `Enumerable#min/#max` uses comparison via elements' `#<=>` method implementation
to determine the minimum or maximum element. Therefore, implementation a `#<=>`
that compares two cards will provide `Enumerable#min/#max` with the functionality
needed to work.
- `Enumerable#min/#max` will return the card object itself that is the min/max. But
according to the test cases, two cards should be equivalent if they simply have
the same properties. Therefore, we must implement a custom Card#== method.

Sub-Problem: Compare two cards

# PROBLEM

*Explicit Requirements*:
- **Input**: Two cards, `self` and `other_card`
- **Output**: -1, 0, or 1 depending on the card comparison

# DATA STRUCTURES

Intermediate: Use a hash to determine the numerical values of each rank?

# ALGORITHM

Given two cards:
- Initialize a hash w/ numerical values
- If the numerical value of card1 > card2 => return 1
- If the numerical value of card1 < card2 => return 1
- Otherwise return 0

# CODE

*Implementation Details*:
- Override #<=> method for comparison purposes

=end

class Card
  include Comparable

  RANK_VALUES = (2..10)
                .zip(2..10)
                .to_h
                .merge({ 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 })
  SUIT_VALUES = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    rank_comparison = compare_ranks(other_card)

    if rank_comparison == 0
      compare_suits(other_card)
    else
      rank_comparison
    end
  end

  def compare_ranks(other_card)
    RANK_VALUES[rank] <=> RANK_VALUES[other_card.rank]
  end

  def compare_suits(other_card)
    SUIT_VALUES[rank] <=> SUIT_VALUES[other_card.rank]
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
  Card.new(10, 'Diamonds'),
  Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
  Card.new(4, 'Diamonds'),
  Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
  Card.new('Jack', 'Diamonds'),
  Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
  Card.new(8, 'Clubs'),
  Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

cards = [Card.new(4, 'Spades'), Card.new(4, 'Clubs'),
         Card.new(10, 'Diamonds'), Card.new(10, 'Hearts')]
puts cards.min == Card.new(4, 'Clubs')
puts cards.max == Card.new(10, 'Hearts')

# Solution simplification: Just define a #<=> method, and use the Comparable
# module to auto-define the other comparison methods (including #==)

# Further Exploration

=begin

Problem

Cards of different suits but the same rank should be considered unequal.
Rank is prioritzed, and then suit is used to differentiate between equal rank
cards.

=end