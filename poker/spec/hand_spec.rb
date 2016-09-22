require 'rspec'
require 'hand'
require 'card'

describe Hand do

  let(:four_of_a_kind) do
    [Card.new("2", "hearts"),
    Card.new("2", "diamonds"),
    Card.new("2", "clubs"),
    Card.new("2", "spades"),
    Card.new("J", "diamonds")]
  end

  let(:full_house) do
    [Card.new("2", "hearts"),
    Card.new("2", "diamonds"),
    Card.new("2", "clubs"),
    Card.new("J", "spades"),
    Card.new("J", "diamonds")]
  end

  let(:full_house2) do
    [Card.new("3", "hearts"),
    Card.new("3", "diamonds"),
    Card.new("3", "clubs"),
    Card.new("J", "spades"),
    Card.new("J", "diamonds")]
  end

  let(:flush) do
    [Card.new("2", "hearts"),
    Card.new("3", "hearts"),
    Card.new("7", "hearts"),
    Card.new("10", "hearts"),
    Card.new("J", "hearts")]
  end

  let(:straight_flush) do
    [Card.new("2", "hearts"),
    Card.new("3", "hearts"),
    Card.new("4", "hearts"),
    Card.new("5", "hearts"),
    Card.new("6", "hearts")]
  end

  let(:straight) do
    [Card.new("9", "spades"),
    Card.new("Q", "hearts"),
    Card.new("K", "hearts"),
    Card.new("10", "hearts"),
    Card.new("J", "hearts")]
  end

  let(:three_of_a_kind) do
    [Card.new("2", "spades"),
    Card.new("2", "diamonds"),
    Card.new("2", "hearts"),
    Card.new("5", "hearts"),
    Card.new("6", "hearts")]
  end

  let(:two_pairs) do
    [Card.new("2", "spades"),
    Card.new("2", "diamonds"),
    Card.new("5", "hearts"),
    Card.new("5", "clubs"),
    Card.new("6", "hearts")]
  end

  let(:one_pair) do
    [Card.new("2", "spades"),
    Card.new("2", "diamonds"),
    Card.new("9", "hearts"),
    Card.new("5", "hearts"),
    Card.new("6", "hearts")]
  end

  let(:high_card) do
    [Card.new("2", "spades"),
    Card.new("K", "diamonds"),
    Card.new("A", "hearts"),
    Card.new("5", "hearts"),
    Card.new("6", "hearts")]
  end

  describe 'initialize' do
    subject(:hand) { Hand.new(four_of_a_kind) }

    it 'should hold 5 cards' do
      expect(hand.cards.count).to eq(5)
    end

    it 'should set rank' do
      expect(hand.rank).to_not be nil
    end
  end

  describe 'rank' do

    describe 'high card' do
      subject(:hand) { Hand.new(high_card) }

      it 'should be high card' do
        hand.set_rank
        expect(hand.rank).to eq("high card")
        expect(hand.rank).to_not eq("one pair")
      end
    end

    describe 'one pair' do
      subject(:hand) { Hand.new(one_pair) }
      it 'should be one pair' do
        hand.set_rank
        expect(hand.rank).to eq("one pair")
      end

    end

    describe 'two pair' do

      subject(:hand) { Hand.new(two_pairs) }
      it 'should be two pair' do
        hand.set_rank
        expect(hand.rank).to eq("two pairs")
      end
    end

    describe 'three of a kind' do

      subject(:hand) { Hand.new(three_of_a_kind) }
      it 'should be three of a kind' do
        hand.set_rank
        expect(hand.rank).to eq("three of a kind")
      end
    end

    describe 'straight' do

      subject(:hand) { Hand.new(straight) }
      it 'should be a straight' do
        hand.set_rank
        expect(hand.rank).to eq("straight")
      end
    end

    describe 'flush' do

      subject(:hand) { Hand.new(flush) }
      it 'should be a flush' do
        hand.set_rank
        expect(hand.rank).to eq("flush")
      end
    end

    describe 'straight_flush' do

      subject(:hand) { Hand.new(straight_flush) }
      it 'should be straight flush' do
        hand.set_rank
        expect(hand.rank).to eq("straight flush")
      end
    end

    describe 'full house' do

      subject(:hand) { Hand.new(full_house) }
      it 'should be full house' do
        hand.set_rank
        expect(hand.rank).to eq("full house")
      end
    end

    describe 'four of a kind' do

      subject(:hand) { Hand.new(four_of_a_kind) }
      it 'should be four of a kind' do
        hand.set_rank
        expect(hand.rank).to eq("four of a kind")
      end
    end
  end


  describe 'winning_hand?' do
    subject(:hand1) { Hand.new(full_house) }
    let(:hand2) { Hand.new(one_pair) }
    let(:hand3) { Hand.new(full_house2) }

    it 'should detect highest rank to be winning' do
      expect(hand1.winning_hand?(hand2)).to be true
      expect(hand2.winning_hand?(hand1)).to be false
    end

    it 'should be able to break tie when players have same rank' do
      expect(hand1.winning_hand?(hand3)).to be false
      expect(hand3.winning_hand?(hand1)).to be true
    end

  end


  describe 'sort' do
    let(:straight2) do
      [Card.new("10", "spades"),
        Card.new("K", "hearts"),
        Card.new("J", "spades"),
        Card.new("9", "clubs"),
        Card.new("Q", "diamonds")]
    end
    subject(:hand) { Hand.new(straight2) }
    it 'sorts cards by highest values first' do
      hand.sort_cards(hand.cards)
      sorted = hand.card_values
      expect(sorted).to eq(["9", "10", "J", "Q", "K"])
    end
  end
end
