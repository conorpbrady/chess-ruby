require './lib/position.rb'
require './lib/board.rb'
require './lib/game_piece.rb'
require './lib/move.rb'


def select_piece(pieces)
  puts "Select pieces to move: "
  input = gets.chomp
  pieces[input.to_i]
end

def select_move(moves)
  puts "Select space to move to"
  input = gets.chomp
  moves[input.to_i]
end

#main

board = Board.new
board.init_pieces
board.draw
game = true
turn = :white
moved = false
while game

  moved = false
  unless moved
    moveable_pieces = board.list_pieces(turn)
    piece = select_piece(moveable_pieces)
    available_moves = board.available_moves(piece)
    if available_moves.empty?
      puts "No legal moves available.  Hit enter to go back to piece selection"
      gets.chomp
      next
    end
    board.list_moves(available_moves)
    move = select_move(available_moves)
    board.remove_piece_at move.to if move.capture
    piece.position = move.to
    move.piece.mark_move if move.piece.class == Pawn

    moved = true
  end

  board.draw
  if turn == :white
    turn = :black
  else
    turn = :white
  end

end
