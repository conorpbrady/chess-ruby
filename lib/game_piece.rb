class GamePiece
  attr_accessor :position, :symbol, :color, :moves

  def initialize(p_str, color)
    x = p_str[0].ord - 64
    y = p_str[1].to_i
    @position = Position.new(x, y)
    @color = color
  end

  def occupies?(x, y)
    return @position.x == x && @position.y == y
  end

  def to_s
    return "#{self.class}"
  end



end


class King < GamePiece
  def initialize(position, color)
    @symbol = color == :white ? "\u2654" : "\u265A"
    @moves = [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]]
    super(position, color)
  end
end

class Queen < GamePiece
  def initialize(position, color)

    @symbol = color == :white ? "\u2655" : "\u265B"
    @moves = [:north, :south, :east, :west, :ne, :sw, :nw, :se]
      super(position, color)
  end
end
class Bishop < GamePiece
  def initialize(position, color)
    @symbol = color == :white ?  "\u2657" : "\u265D"

    @moves =  [:ne, :se, :nw, :sw]
    super(position, color)
  end
end
class Knight < GamePiece
  def initialize(position, color)
    @symbol = color == :white ? "\u2658" : "\u265E"

    @moves = [
      [1,2],
      [2,1],
      [-1,2],
      [-2,1],
      [1,-2],
      [2,-1],
      [-1,-2],
      [-2,-1]
    ]
    super(position, color)
  end
end
class Rook < GamePiece

  def initialize(position, color)
    @symbol = color == :white ? "\u2656" : "\u265C"

    @moves = [:north, :south, :east, :west]
    super(position, color)
  end
end
class Pawn < GamePiece

  def initialize(position, color)
    @symbol = color == :white ? "\u2659" : "\u265F"
    @color = color
    @moved = false
    if @color == :black
      @moves = [[0,1], [0,2]]
    else
      @moves = [[0,-1], [0,-2]]
    end

    super(position, color)
  end
  def remove_first_move
    return if @moved
    @moves.delete([0,2])
    @moves.delete([0,-2])
    @moved = true
  end

  def check_capture
  end
  def promote
  end

  def en_passant
  end
end
