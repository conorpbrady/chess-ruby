require './lib/position.rb'
require './lib/game_piece.rb'

class Board
  attr_accessor :board
  def initialize
    @white_pieces = []
    @black_pieces = []
    @board = Hash.new
    define_positions()
  end

  def draw
    puts "    A   B   C   D   E   F   G   H  "
    puts "  ---------------------------------"
    (1..8).each do |n|
      print "#{n} |"
      (1..8).each do |m|
        token = get_piece_on_space((m+64).chr + n.to_s)
        token_symbol = token.nil? ?  " " : token.symbol
        print " " + token_symbol + " " + "|"
      end
      puts ""
      puts "  ---------------------------------"
    end
  end

  def is_open_space?(p_str)
    @white_pieces.each { |piece| return false if piece.occupies?(p_str) }
    @black_pieces.each { |piece| return false if piece.occupies?(p_str) }
    return true
  end

  def get_piece_on_space(p_str)
    @white_pieces.each { |piece| return piece if piece.occupies?(p_str) }
    @black_pieces.each { |piece| return piece if piece.occupies?(p_str) }
    return nil
  end

  def in_bounds?(position)
    return (position.x > 8 || position.x < 0 || position.y > 8 || position.y < 0)
  end

  def define_positions()
    (1..8).each do |n|
      char = (64 + n).chr
      @board[char] = []
      (1..8).each do |m|
        @board[char] << Position.new(n,m)
      end
    end
  end

  def pos(str)
    @board[str[0]][str[1].to_i - 1]
  end

  def init_pieces
    colors = ['W','B']
      @white_pieces << Rook.new(pos('A8'), :white)
      @white_pieces << Knight.new(pos('B8'), :white)
      @white_pieces << Bishop.new(pos('C8'), :white)
      @white_pieces << Queen.new(pos('D8'), :white)
      @white_pieces << King.new(pos('E8'), :white)
      @white_pieces << Bishop.new(pos('F8'), :white)
      @white_pieces << Knight.new(pos('G8'), :white)
      @white_pieces << Rook.new(pos('H8'), :white)

      (1..8).each do |n|
        @white_pieces << Pawn.new(pos((64+n).chr + '7'), :white)
      end

      @black_pieces << Rook.new(pos('A1'),:black)
      @black_pieces << Knight.new(pos('B1'),:black)
      @black_pieces << Bishop.new(pos('C1'),:black)
      @black_pieces << Queen.new(pos('D1'),:black)
      @black_pieces << King.new(pos('E1'),:black)
      @black_pieces << Bishop.new(pos('F1'),:black)
      @black_pieces << Knight.new(pos('G1'),:black)
      @black_pieces << Rook.new(pos('H1'),:black)

      (1..8).each do |n|
        @black_pieces << Pawn.new(pos((64+n).chr + '2'), :black)
      end

    end

end
