class GamePiece
  attr_accessor :position, :symbol, :color

  def initialize(p_str)
    x = p_str[0].ord - 64
    y = p_str[1].to_i
    @position = Position.new(x, y)
  end

  def occupies?(p_str)
    x = p_str[0].ord - 64
    y = p_str[1].to_i
    return @position.x == x && @position.y == y
  end

end


class King < GamePiece
  def initialize(position, color)
    @symbol = color == :white ? "\u2654" : "\u265A"
    @moves = [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]]
    super(position)
  end
end

class Queen < GamePiece
  def initialize(position, color)

    @symbol = color == :white ? "\u2655" : "\u265B"
    @moves = [
      [0,'x'],
      ['x','-x'],
      ['x',0],
      ['x','x'],
      [0,'x'],
      ['-x','x'],
      ['-x',0],
      ['-x','-x']
      ]
      super(position)
  end
end
class Bishop < GamePiece
  def initialize(position, color)
    @symbol = color == :white ?  "\u2656" : "\u265C"

    @moves =  [
      ['x','x'],
      ['-x','x'],
      ['x','-x'],
      ['-x','-x']
    ]
    super(position)
  end
end
class Knight < GamePiece
  def initialize(position, color)
    @symbol = color == :white ? "\u2657" : "\u265D"

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
    super(position)
  end
end
class Rook < GamePiece

  def initialize(position, color)
    @symbol = color == :white ? "\u2658" : "\u265E"

    @moves = [
      [0,'x'],
      [0,'-x'],
      ['x',0],
      ['-x',0]
    ]
    super(position)
  end
end
class Pawn < GamePiece

  def initialize(position, color)
    @symbol = color == :white ? "\u2659" : "\u265F"

    @color = color
    if @color == 'W'
      @moves = [[0,1]]
    else
      @moves = [[0,-1]]
    end

    super(position)
  end
  def first_move
  end

  def promote
  end

  def en_passant
  end
end
