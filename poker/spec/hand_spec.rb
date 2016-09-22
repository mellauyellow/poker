require 'rspec'
require 'hand'
require 'card'

describe Hand do

  let(:four_of_a_kind) do
    [double("card1", :value => "2", :suit => "hearts"),
    double("card2", :value => "2", :suit => "diamonds"),
    double("card3", :value => "2", :suit => "clubs"),
    double("card4", :value => "2", :suit => "spades"),
    double("card5", :value => "J", :suit => "diamonds")]
  end

  let(:full_house) do
    [double("card1", :value => "2", :suit => "hearts"),
    double("card2", :value => "2", :suit => "diamonds"),
    double("card3", :value => "2", :suit => "clubs"),
    double("card4", :value => "J", :suit => "spades"),
    double("card5", :value => "J", :suit => "diamonds")]
  end

  let(:full_house2) do
    [double("card1", :value => "3", :suit => "hearts"),
    double("card2", :value => "3", :suit => "diamonds"),
    double("card3", :value => "3", :suit => "clubs"),
    double("card4", :value => "J", :suit => "spades"),
    double("card5", :value => "J", :suit => "diamonds")]
  end

  let(:flush) do
    [double("card1", :value => "2", :suit => "hearts"),
    double("card2", :value => "3", :suit => "hearts"),
    double("card3", :value => "7", :suit => "hearts"),
    double("card4", :value => "10", :suit => "hearts"),
    double("card5", :value => "J", :suit => "hearts")]
  end

  let(:straight_flush) do
    [double("card1", :value => "2", :suit => "hearts"),
    double("card2", :value => "3", :suit => "hearts"),
    double("card3", :value => "4", :suit => "hearts"),
    double("card4", :value => "5", :suit => "hearts"),
    double("card5", :value => "6", :suit => "hearts")]
  end

  let(:straight) do
    [double("card1", :value => "9", :suit => "spades"),
    double("card2", :value => "Q", :suit => "hearts"),
    double("card3", :value => "K", :suit => "hearts"),
    double("card4", :value => "10", :suit => "hearts"),
    double("card5", :value => "J", :suit => "hearts")]
  end

  let(:three_of_a_kind) do
    [double("card1", :value => "2", :suit => "spades"),
    double("card2", :value => "2", :suit => "diamonds"),
    double("card3", :value => "2", :suit => "hearts"),
    double("card4", :value => "5", :suit => "hearts"),
    double("card5", :value => "6", :suit => "hearts")]
  end

  let(:two_pairs) do
    [double("card1", :value => "2", :suit => "spades"),
    double("card2", :value => "2", :suit => "diamonds"),
    double("card3", :value => "5", :suit => "hearts"),
    double("card4", :value => "5", :suit => "clubs"),
    double("card5", :value => "6", :suit => "hearts")]
  end

  let(:one_pair) do
    [double("card1", :value => "2", :suit => "spades"),
    double("card2", :value => "2", :suit => "diamonds"),
    double("card3", :value => "9", :suit => "hearts"),
    double("card4", :value => "5", :suit => "hearts"),
    double("card5", :value => "6", :suit => "hearts")]
  end

  let(:high_card) do
    [double("card1", :value => "2", :suit => "spades"),
    double("card2", :value => "K", :suit => "diamonds"),
    double("card3", :value => "A", :suit => "hearts"),
    double("card4", :value => "5", :suit => "hearts"),
    double("card5", :value => "6", :suit => "hearts")]
  end

  describe 'initialize' do
    subject(:hand) { Hand.new(four_of_a_kind) }

    it 'should hold 5 cards' do
      expect(hand.cards.count).to eq(5)
    end

    it 'should have no rank set' do
      expect(hand.rank).to be nil
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
      [Card.new("spades", "10"),
        Card.new("hearts", "K"),
        Card.new("spades", "J"),
        Card.new("clubs", "9"),
        Card.new("diamonds", "Q")]
    end
    subject(:hand) { Hand.new(straight2) }
    it 'sorts cards by highest values first' do
      hand.sort_cards(hand.cards)
      sorted = hand.card_values
      expect(sorted).to eq(["9", "10", "J", "Q", "K"])
    end
  end
end
