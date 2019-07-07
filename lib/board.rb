require './lib/position.rb'
require './lib/game_piece.rb'

class Board
  attr_accessor :board, :active_pieces

  def initialize
    @active_pieces = []
    @board = Hash.new
  end

  def draw
    puts "    A   B   C   D   E   F   G   H  "
    puts "  ---------------------------------"
    (1..8).each do |n|
      print "#{n} |"
      (1..8).each do |m|
        token = get_piece_at(x: m, y: n)
        token_symbol = token.nil? ?  " " : token.symbol
        print " " + token_symbol + " " + "|"
      end
      puts ""
      puts "  ---------------------------------"
    end
  end

  def get_piece_at(p_str: nil, x: nil, y: nil)
    if x.nil?
      x = p_str[0].ord - 64
      y = p_str[1].to_i
    end
    @active_pieces.each { |piece| return piece if piece.occupies?(x,y) }
    return nil
  end

  def list_pieces(color)
    moveable_pieces = Hash.new
    i = 1

    @active_pieces.each do |piece|
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

  def list_moves(moves)
    moves.each do |key, move|
      print "#{key}. #{move}"
      print " (capture #{get_piece_at(x: move.to.x, y: move.to.y)})" if move.capture
      puts ""
    end
  end

  def available_moves(piece)
    open_moves = Hash.new
    color = piece.color
    i = 1
    piece.moves.each do |move|

      dx, dy, can_capture = move.is_a?(Symbol) ? piece.open_path(move) : move

      new_x = piece.position.x + dx
      new_y = piece.position.y + dy
      move_type = get_move_type(new_x, new_y, color, can_capture)
      while move_type != :invalid
        capture = move_type == :capture
        open_moves[i] = Move.new(piece, piece.position, Position.new(new_x, new_y), capture)
        i += 1
        break if move.is_a?(Array)
        break if capture
        new_x += dx
        new_y += dy
        move_type = get_move_type(new_x, new_y, color, can_capture)
      end
    end
    return open_moves
  end

  def get_move_type(x, y, color, is_capture_only_move)

    dest_piece = get_piece_at(x: x, y: y)

    return :invalid unless in_bounds?(x, y)

    if get_piece_at(x: x, y: y).nil?
      return :open if is_capture_only_move.nil?
      return :open unless is_capture_only_move
      return :invalid if is_capture_only_move
    end

    return :invalid if dest_piece.color == color

    if dest_piece.color != color
      return is_capture_only_move ? :capture : :invalid
    end
  end

  def remove_piece_at(position)
    @active_pieces.each { |piece| active_pieces.delete(piece) if piece.occupies?(position.x, position.y) }
  end

  def in_bounds?(x, y)
    return (x < 9 && x > 0 && y < 9 && y > 0)
  end

  def init_pieces

      @active_pieces << Rook.new('A8', :white)
      @active_pieces << Knight.new('B8', :white)
      @active_pieces << Bishop.new('C8', :white)
      @active_pieces << Queen.new('D8', :white)
      @active_pieces << King.new('E8', :white)
      @active_pieces << Bishop.new('F8', :white)
      @active_pieces << Knight.new('G8', :white)
      @active_pieces << Rook.new('H8', :white)

      (1..8).each do |n|
        @active_pieces << Pawn.new((64+n).chr + '7', :white)
      end

      @active_pieces << Rook.new('A1',:black)
      @active_pieces << Knight.new('B1',:black)
      @active_pieces << Bishop.new('C1',:black)
      @active_pieces << Queen.new('D1',:black)
      @active_pieces << King.new('E1',:black)
      @active_pieces << Bishop.new('F1',:black)
      @active_pieces << Knight.new('G1',:black)
      @active_pieces << Rook.new('H1',:black)

      (1..8).each do |n|
        @active_pieces << Pawn.new((64+n).chr + '2', :black)
      end

    end

end
