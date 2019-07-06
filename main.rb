require './lib/position.rb'
require './lib/board.rb'
require './lib/game_piece.rb'

def display_pieces(board, color)
  pieces = color == :white ? board.white_pieces : board.black_pieces
  moveable_pieces = Hash.new
  i = 1
  pieces.each do |piece|
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

def available_moves(board, piece)
  open_moves = Hash.new

  i = 1
  piece.moves.each do |move|

    dx, dy = move.is_a?(Symbol) ? open_path(move) : move

    new_x = piece.position.x + dx
    new_y = piece.position.y + dy
    while board.in_bounds?(new_x, new_y) && board.is_open_space?(x: new_x, y: new_y)
      open_moves[i] = Position.new(new_x, new_y)
      i += 1
      break if move.is_a?(Array)
      new_x += dx
      new_y += dy
    end
  end
  return open_moves
end

def display_and_get_move(moves)
  moves.each do |key, move|
    puts "#{key}. #{move}"
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
    am = available_moves(b, p)
    if am.empty?
      puts "No legal moves available.  Hit enter to go back to piece selection"
      gets.chomp
      next
    end
    new_position = display_and_get_move(am)
    p.position = new_position
    moved = true
  end

  b.draw
  if turn == :white
    turn = :black
  else
    turn = :white
  end

end
