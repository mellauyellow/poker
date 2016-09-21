require 'rspec'
require 'deck'
require 'card'

describe Deck do
  subject(:deck) { Deck.new }

  describe "initialize" do
    it 'initializes with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end

    it 'creates four cards for every value' do
      full_deck = Hash.new(0)
      deck.cards.each do |card|
        full_deck[card.value] += 1
      end
      expect(full_deck.values).to eq([4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4])
      expect(full_deck.keys.sort).to eq(%w(2 3 4 5 6 7 8 9 10 J Q K A).sort)
    end

    it 'creates 13 cards for every suit' do
      full_deck = Hash.new{ |hash, key| hash[key] = [] }
      deck.cards.each do |card|
        full_deck[card.suit] << card.value
      end
      expect(full_deck.keys.sort).to eq(%w(hearts diamonds clubs spades).sort)
      expect(full_deck.values.all?{|value| value = %w(2 3 4 5 6 7 8 9 10 J Q K A) }).to be true
    end
  end

  describe 'shuffle' do

    it 'shuffles the cards in random order' do
      unshuffled_cards = deck.cards.dup
      deck.shuffle
      shuffled_cards = deck.cards

      expect(shuffled_cards).to_not eq(unshuffled_cards)
    end
  end
end
