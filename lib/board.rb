require './lib/position.rb'
require './lib/game_piece.rb'
require './lib/move.rb'

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
        token = get_piece_at(m, n)
        token_symbol = token.nil? ?  " " : token.symbol
        print " " + token_symbol + " " + "|"
      end
      puts ""
      puts "  ---------------------------------"
    end
  end

  def get_piece_at(x, y)
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
      print " (capture #{get_piece_at(move.to.x, move.to.y)})" if move.capture
      puts ""
    end
  end

  def available_moves(piece, check_test_only: false)
    open_moves = Hash.new
    color = piece.color
    i = 1
    piece.moves.each do |move|

      dx, dy, can_capture = move.is_a?(Symbol) ? piece.open_path(move) : move

      new_x = piece.position.x + dx
      new_y = piece.position.y + dy

      move_type = get_move_type(new_x, new_y, color, can_capture)

      #King cannot move into check
      break if piece.class == King && check_test(color, x: new_x, y: new_y) unless check_test_only
      break if move_type == :invalid && piece.class == Pawn && dx.zero?

      while move_type != :invalid
        unless check_test_only #prevents infinite looping

          #Another piece cannot move to put king into check
          #Saves original position, moves piece, then runs check condition
          #Also simulates capture of opponent's piece
          init_pos = piece.position
          clone_piece = get_piece_at(new_x, new_y)

          piece.position = Position.new(new_x, new_y)
          @active_pieces.delete(clone_piece) if move_type == :capture

          ct = check_test(color)
          "Check #{ct} with #{piece} @ #{piece.position}"
          piece.position = init_pos
          @active_pieces << clone_piece if move_type == :capture
          break if ct
        end

        capture = move_type == :capture
        break if capture && check_test_only
        open_moves[i] = Move.new(piece, piece.position, Position.new(new_x, new_y), capture) unless (check_test_only && move_type != :check)
        i += 1
        break if move.is_a?(Array)
        break if capture || move_type == :check
        new_x += dx
        new_y += dy
        move_type = get_move_type(new_x, new_y, color, can_capture)
      end
    end
    return open_moves
  end

  def get_move_type(x, y, color, is_capture_only_move)

    dest_piece = get_piece_at(x, y)

    return :invalid unless in_bounds?(x, y)

    if get_piece_at(x, y).nil?
      return :open if is_capture_only_move.nil?
      return :open unless is_capture_only_move
      return :invalid if is_capture_only_move
    end

    return :invalid if dest_piece.color == color

    if dest_piece.color != color
      return :check if dest_piece.class == King
      return is_capture_only_move || is_capture_only_move.nil? ? :capture : :invalid
    end
  end

  def remove_piece_at(position)
    @active_pieces.each { |piece| active_pieces.delete(piece) if piece.occupies?(position.x, position.y) }
  end

  def in_bounds?(x, y)
    return (x < 9 && x > 0 && y < 9 && y > 0)
  end

  def get_king(color)
      king = @active_pieces.each { |piece| return piece if piece.class.equal?(King) && piece.color == color }
      @active_pieces.each do |piece|
      end
      raise Exception "No king found"
  end

  def mate_test(color)
    return false if check_test(color)
    all_moves = []
    @active_pieces.each do |piece|
      next if piece.color.equal?(color)
      all_moves << available_moves(piece, check_test_only: true)



  end

  def check_test(color, x: nil, y: nil)

    if x.nil?
      k = get_king(color)
      kx = k.position.x
      ky = k.position.y
    else
      kx = x
      ky = y
    end

    @active_pieces.each do |piece|
      next if piece.color.equal?(color)
      available_moves(piece, check_test_only: true).each do |key, move|
        return true if kx == move.to.x && ky == move.to.y
      end
    end
    return false
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
