class GamePiece
  attr_accessor :position, :symbol, :color

  def initialize(position)
    @position = position
  end

end


class King < GamePiece
  @symbol = 'K'
  @moves = [[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]]
end
class Queen < GamePiece
  @symbol = 'Q'
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
end
class Bishop < GamePiece
  @symbol = 'B'
  @moves =  [
    ['x','x'],
    ['-x','x'],
    ['x','-x'],
    ['-x','-x']
  ]
end
class Knight < GamePiece
  @symbol = 'N'
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
end
class Rook < GamePiece
  @symbol = 'R'
  @moves = [
    [0,'x'],
    [0,'-x'],
    ['x',0],
    ['-x',0]
  ]
end
class Pawn < GamePiece
  @symbol = 'P'
  def initialize(position, color)
    @color = color
    if @color == 'W'
      @moves = [[0,1]]
    else
      @moves = [[0,-1]]
    end
    @position = position
  end
  def first_move
  end

  def promote
  end

  def en_passant
  end
end
