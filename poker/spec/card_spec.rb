require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new("2", "hearts") }
  describe 'initialize' do
    it 'should initalize with a card value and suit' do
      expect(card.value).to eq("2")
      expect(card.suit).to eq("hearts")
    end
  end

  let(:card2) { Card.new("A", "hearts") }
  describe '<=>' do
    it 'should compare two card values based on index' do
      expect(card < card2).to be true
    end
  end
end
