require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = make_full_deck
  end

  def make_full_deck
    values = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits = %w(hearts diamonds clubs spades)
    cards = []
    values.each do |value|
      suits.each do |suit|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def shuffle
    @cards.shuffle!
  end
end
