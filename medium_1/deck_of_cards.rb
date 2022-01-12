# Deck of Cards

=begin

Problem
- Initialize deck of cards with 52 cards, shuffled
- `Deck#draw`:
  - Pop one card from the deck
  - If no more cards, re-initialize deck (call #initialize?)

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

  def <=>(other_card)
    VALUES[rank] <=> VALUES[other_card.rank]
  end

  def ==(other_card)
    rank == other_card.rank && suit == other_card.suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn2.size
puts drawn != drawn2 # Almost always.