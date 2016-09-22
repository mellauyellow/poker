class Card
  include Comparable

  attr_reader :suit, :value
  CARD_ORDER = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  def initialize(suit, value)
    @suit, @value = suit, value
  end

  def <=>(other_card)
    CARD_ORDER.index(@value) <=> CARD_ORDER.index(other_card.value)
  end

end
