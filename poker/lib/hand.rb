require_relative 'card'
require 'byebug'

class Hand
  attr_reader :cards, :rank
  CARD_ORDER = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  RANK_ORDER = ["straight flush", "four of a kind", "full house", "flush", "straight", "three of a kind", "two pairs", "one pair", "high card"]
  def initialize(cards)
    @cards = cards
    @rank = nil
    sort_cards(@cards)
  end

  def sort_cards(cards)
    return cards if cards.length <= 1
    pivot = cards.shift
    left = cards.select { |card| card < pivot }
    right = cards.select { |card| card >= pivot }
    @cards = sort_cards(left) + [pivot] + sort_cards(right)
  end

  def straight?(card_values)
    card_indexes = card_values.map {|value| CARD_ORDER.index(value) }
    card_indexes.sort!.each_with_index do |card_idx, idx|
      next if idx == card_indexes.length - 1
      return false unless card_indexes[idx + 1] == card_idx + 1
    end
    true
  end

  def same_value_cards(card_values)
    repeat_values = Hash.new(0)

    card_values.each { |value| repeat_values[value] += 1 }

    repeat_values.select { |card_value, count| count > 1 }
  end

  def flush?
    suits = @cards.map {|card| card.suit}
    suits.uniq.length == 1 ? true : false
  end

  def set_rank
    repeat_values = same_value_cards(card_values)

    if repeat_values.empty?
      if straight?(card_values) && flush?
        @rank = "straight flush"
      elsif straight?(card_values)
        @rank = "straight"
      elsif flush?
        @rank = "flush"
      else
        @rank = "high card"
      end
    else
      if repeat_values.values == [4]
        @rank = "four of a kind"
      elsif repeat_values.values == [3]
        @rank = "three of a kind"
      elsif repeat_values.values == [2]
        @rank = "one pair"
      else
        @rank = repeat_values.values == [2, 2] ? "two pairs" : "full house"
      end
    end
  end

  def card_values
    @cards.map { |card| card.value }
  end

  def high_card
    @cards.last
  end

  def highest_card?(other_hand)
    
    until our_cards.empty?
      if high_card(our_hand) > other_hand.high_card(other_hand)
        return true
      elsif high_card(our_hard) < other_hand.high_card(other_hand)
        return false
      else
        previous_high_card = high_card(our_hand)
        our_cards.delete(previous_high_card)
        their_cards.delete(previous_high_card)
      end
    end
  end

  def tie_breaker?(other_hand)
    our_cards = self.card_values
    their_cards = other_hand.card_values

    if ["straight flush", "straight", "flush", "high card"].include?(@rank)
      return highest_card?(@cards, other_hand)
    elsif @rank == "full house"
      our_high_card = same_value_cards(our_cards).key(3)
      their_high_card = same_value_cards(our_cards).key(3)

      our_high_card > their_high_card ? true : false
    else
      our_high_card = same_value_cards(our_cards).keys.max
      their_high_card = same_value_cards(their_cards).keys.max
      if our_high_card > their_high_card
        return true
      elsif our_high_card < their_high_card
        return false
      # else

      end
    end
  end

  def winning_hand?(other_hand)
    if RANK_ORDER.index(@rank) < RANK_ORDER.index(other_hand.rank)
      return true
    elsif RANK_ORDER.index(@rank) > RANK_ORDER.index(other_hand.rank)
      return false
    else
      tie_breaker
    end
  end

end
