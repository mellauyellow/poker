require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new("hearts", "2") }
  describe 'initialize' do
    it 'should initalize with a card value and suit' do
      expect(card.value).to eq("2")
      expect(card.suit).to eq("hearts")
    end
  end

  let(:card2) { Card.new("hearts", "A") }
  describe '<=>' do
    it 'should compare two card values based on index' do
      expect(card < card2).to be true
    end
  end
end
