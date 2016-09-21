require 'rspec'
require 'tower_of_hanoi'


describe 'tower_of_hanoi#move' do
  subject(:game) { TowerOfHanoi.new }

  it 'moves piece from one tower to another' do
    game.move(0,2)
    expect(game.towers).to eq([[2, 3], [], [1]])
  end

  it 'doesn\'t allow invalid moves' do
    game.move(0,2)
    expect { game.move(0,2) }.to raise_error("Invalid move")
    expect(game.towers).to eq([[2, 3], [], [1]])
  end

  it 'doesn\'t take from an empty tower' do
    expect { game.move(1,2) }.to raise_error("Tower's empty")
  end

  it 'can move piece to empty tower'do
    expect { game.move(0, 1) }.to_not raise_error
  end
end

describe 'tower_of_hanoi#won?' do
  subject(:game) { TowerOfHanoi.new }

  it 'returns true if game over' do
    game.towers = [[], [1, 2, 3], []]
    expect(game.won?).to be true
  end

  it 'returns false if game is not won' do
    game.towers = [[1], [2, 3], []]
    expect(game.won?).to be false
  end

  it 'returns false at start of game' do
    expect(game.won?).to be false
  end
end
