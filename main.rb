require './lib/position.rb'
require './lib/board.rb'
require './lib/game_piece.rb'
require './lib/move.rb'

def display_pieces(board, color)
  moveable_pieces = Hash.new
  i = 1

  board.active_pieces.each do |piece|
    next unless piece.color == color
    print "#{i}. #{piece.class} @ #{piece.position}"
    moveable_pieces[i] = piece
    if i % 4 == 0
      puts ""
    else
      print ", "
    end
    i = i + 1
  end
  puts ""
  return moveable_pieces
end

def piece_to_move(pieces)
  puts "Select pieces to move: "
  input = gets.chomp
  pieces[input.to_i]
end

def open_path(d)
  dx = 0
  dy = 0

  dx = 1 if(d == :east || d == :ne || d == :se)
  dx = -1 if(d == :west || d == :nw || d == :sw)

  dy = -1 if(d == :north || d == :nw || d == :ne)
  dy = 1 if(d == :south || d == :sw || d == :se)
  return [dx, dy]

end
def get_move_type(board, x, y, color)
  dest_piece = board.get_piece_at(x: x, y: y)
  return :invalid unless board.in_bounds?(x, y)
  return :open if dest_piece.nil?
  return :capture if dest_piece.color != color
  return :invalid if dest_piece.color == color


end
def available_moves(board, piece, color)
  open_moves = Hash.new

  i = 1
  piece.moves.each do |move|

    dx, dy = move.is_a?(Symbol) ? open_path(move) : move

    new_x = piece.position.x + dx
    new_y = piece.position.y + dy
    move_type = get_move_type(board, new_x, new_y, color)
    while move_type != :invalid
      capture = move_type == :capture
      open_moves[i] = Move.new(piece, piece.position, Position.new(new_x, new_y), capture)
      i += 1

      break if move.is_a?(Array)
      break if capture
      new_x += dx
      new_y += dy
      move_type = get_move_type(board, new_x, new_y, color)
    end
  end
  return open_moves
end

def display_and_get_move(board, moves)
  moves.each do |key, move|
    print "#{key}. #{move}"
    print " (capture #{board.get_piece_at(x: move.to.x, y: move.to.y)})" if move.capture
    puts ""
  end
  puts "Select space to move to"
  input = gets.chomp
  moves[input.to_i]
end



#main

b = Board.new
b.init_pieces
b.draw
game = true
turn = :white
moved = false
while game

  moved = false
  unless moved
    mp = display_pieces(b, turn)
    p = piece_to_move(mp)
    am = available_moves(b, p, turn)
    if am.empty?
      puts "No legal moves available.  Hit enter to go back to piece selection"
      gets.chomp
      next
    end
    move = display_and_get_move(b, am)
    b.remove_piece_at move.to if move.capture
    p.position = move.to
    move.piece.remove_first_move if move.piece.class == Pawn


    moved = true
  end

  b.draw
  if turn == :white
    turn = :black
  else
    turn = :white
  end

end
