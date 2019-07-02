class Board

  def initialize
    white_pieces = []
    black_pieces = []
  end

  def draw

  end

  def is_open_space?(position)
    white_pieces.each { |piece| return false if piece.position.occupies?(position) }
    black_pieces.each { |piece| return false if piece.position.occupies?(position) }

  end

  def in_bounds?(position)
    return (position.x > 8 || position.x < 0 || position.y > 8 || position.y < 0)

  end

  def init_pieces
    colors = ['W','B']
      white_pieces.add(Rook.new('A1'))
      white_pieces.add(Knight.new('B1'))
      white_pieces.add(Bishop.new('C1'))
      white_pieces.add(Queen.new('D1'))
      white_pieces.add(King.new('E1'))
      white_pieces.add(Bishop.new('F1'))
      white_pieces.add(Knight.new('G1'))
      white_pieces.add(Rook.new('H1'))

    end

end
