class Board

  def initialize
    white_pieces = []
    black_pieces = []
  end

  def draw

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
