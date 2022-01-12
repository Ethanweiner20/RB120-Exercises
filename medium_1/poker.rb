# Poker

=begin

Requirements:
- If the `deck` is larger than 5 cards, limit to 5

=end

# Include Card and Deck classes from the last two exercises.

# Solution 1

=begin
class PokerHand
  HAND_SIZE = 5

  def initialize(deck)
    @cards = []
    draw_hand(deck)
    # @rank_count = {} <== Would help for counting purposes
  end

  def draw_hand(deck)
    HAND_SIZE.times { cards << deck.draw }
    cards.sort! # Sort for comparison purposes
  end

  def print
    puts cards
  end

  # Short-circuits upon finding first match; ordered by value => properly
  # evaluates
  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_reader :cards

  # Includes 10JQKA same suit
  def royal_flush?
    flush? && royal?
  end

  def royal?
    cards.map(&:rank) == [10, 'Jack', 'Queen', 'King', 'Ace']
  end

  def straight_flush?
    straight? && flush?
  end

  # Do four of the cards have an equal rank?
  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def flush?
    cmp_suit = cards[0].suit
    cards.all? { |card| card.suit == cmp_suit }
  end

  # Are the ranks directly in sequence?
  def straight?
    (1..HAND_SIZE - 1).all? do |index|
      cards[index] - cards[index - 1] == 1
    end
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    Deck::RANKS.count { |rank| cards_with_rank(rank) == 2 } == 2
  end

  def pair?
    n_of_a_kind?(2)
  end

  def n_of_a_kind?(n)
    Deck::RANKS.any? { |rank| cards_with_rank(rank) == n }
  end

  def cards_with_rank(rank)
    cards.count { |card| card.rank == rank }
  end
end
=end
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def regenerate_cards
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end
  end

  def draw
    reset if cards.empty?
    cards.pop
  end

  private

  attr_accessor :cards

  def reset
    self.cards = []
    regenerate_cards
    cards.shuffle!
  end
end

class Card
  include Comparable

  VALUES = (2..10)
           .zip(2..10)
           .to_h
           .merge({ 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 })

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES[rank]
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def -(other_card)
    value - other_card.value
  end

  def ==(other_card)
    rank == other_card.rank && suit == other_card.suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

# Solution 2

class PokerHand
  HAND_SIZE = 5

  def initialize(deck)
    @cards = []
    draw_hand(deck)
    @rank_counts = cards.map(&:rank).tally
  end

  def draw_hand(deck)
    HAND_SIZE.times { cards << deck.draw }
    cards.sort! # Sort for comparison purposes
  end

  def print
    puts cards
  end

  # Short-circuits upon finding first match; ordered by value => properly
  # evaluates
  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_reader :cards, :rank_counts

  # Includes 10JQKA same suit
  def royal_flush?
    flush? && royal?
  end

  def royal?
    cards.map(&:rank) == [10, 'Jack', 'Queen', 'King', 'Ace']
  end

  def straight_flush?
    straight? && flush?
  end

  # Do four of the cards have an equal rank?
  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def flush?
    cmp_suit = cards[0].suit
    cards.all? { |card| card.suit == cmp_suit }
  end

  def straight?
    rank_counts.values.all?(1) && cards.max.value - cards.min.value == 4
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    rank_counts.count { |_, count| count == 2 } == 2
  end

  def pair?
    n_of_a_kind?(2)
  end

  def n_of_a_kind?(n)
    rank_counts.values.include?(n)
  end
end

hand = PokerHand.new(Deck.new)
hand.print
# puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'


hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

# Further Exploration

=begin

1. I would have to structure my code in a few different ways:
- Parameter passing (I would need to pass the `cards` around, since they are no
longer stored in the state of an instance)
- Rank counts: The rank counts are no longer available as part of a state, so
we must compute the rank counts as necessary for usage in any of the class
methods

2. I would evaluate the hand type upon initialization, and store it in an
instance variable `@hand_type`. I would then implement a comparison method, such
as PokerHand#< and PokerHand#>, that instructs poker hands to be compared by
their respective `@hand_type`. I could use an ordered array of `HAND_TYPES` to
perform this comparison (and use this same array for the evaluation process).

3. Upon initialization, I would form all possible hands from the 7 cards,
and choose the best possible hand, using the comparison logic from question 2.

Given an array of 7 Cards:
- Create all subsets of 5 cards
- Transform each subset to a `PokerHand`
- Determine the maximum `PokerHand` and return
  - Comparison logic is based on each hand's computed `hand_type`

=end