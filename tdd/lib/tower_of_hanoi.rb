class TowerOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[1, 2, 3], [], []]
  end

  def move(from_tower, to_tower)
    if valid_move?(from_tower, to_tower)
      move_piece = @towers[from_tower].shift
      @towers[to_tower].unshift(move_piece)
    else
      raise "Invalid move"
    end
  end

  def valid_move?(from_tower, to_tower)
    raise "Tower's empty" if @towers[from_tower].first.nil?
    unless @towers[to_tower].empty?
      move_piece = @towers[from_tower].first
      tower_piece = @towers[to_tower].first
      return false if tower_piece < move_piece
    end

    true
  end

  def won?
    return true if @towers[1] == [1,2,3] || @towers[2] == [1,2,3]
    false
  end
end
