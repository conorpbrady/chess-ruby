require './lib/position.rb'
require './lib/board.rb'
require './lib/game_piece.rb'

b = Board.new
b.init_pieces
b.draw


def display_moves(board, color)
  pieces = color == :white ? board.white_pieces : board.black_pieces
  i = 1
  pieces.each do |piece|
    print "#{i}. #{piece.class} @ #{piece.position}, "
    i = i + 1
  end

end


display_moves(b, :white)
