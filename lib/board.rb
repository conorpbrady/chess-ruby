require './lib/position.rb'
require './lib/game_piece.rb'

class Board
  attr_accessor :board, :white_pieces, :black_pieces

  def initialize
    @white_pieces = []
    @black_pieces = []
    @board = Hash.new
  #  define_positions()
  end

  def draw
    puts "    A   B   C   D   E   F   G   H  "
    puts "  ---------------------------------"
    (1..8).each do |n|
      print "#{n} |"
      (1..8).each do |m|
        token = get_piece_on_space(x: m, y: n)
        token_symbol = token.nil? ?  " " : token.symbol
        print " " + token_symbol + " " + "|"
      end
      puts ""
      puts "  ---------------------------------"
    end
  end

  def is_open_space?(p_str:  nil, x: nil, y: nil)
    if x.nil?
      x = p_str[0].ord - 64
      y = p_str[1].to_i
    end
    @white_pieces.each { |piece| return false if piece.occupies?(x, y) }
    @black_pieces.each { |piece| return false if piece.occupies?(x, y) }
    return true
  end

  def get_piece_on_space(p_str: nil, x: nil, y: nil)
    if x.nil?
      x = p_str[0].ord - 64
      y = p_str[1].to_i
    end
    @white_pieces.each { |piece| return piece if piece.occupies?(x,y) }
    @black_pieces.each { |piece| return piece if piece.occupies?(x,y) }
    return nil
  end

  def in_bounds?(x, y)
    return (x < 9 && x > 0 && y < 9 && y > 0)
  end

  # def define_positions()
  #  (1..8).each do |n|
  #    char = (64 + n).chr
  #    @board[char] = []
  #    (1..8).each do |m|
  #      @board[char] << Position.new(n,m)
  #    end
  #  end
  # end

  #def pos(str)
  #  @board[str[0]][str[1].to_i - 1]
  #end

  def init_pieces

      @white_pieces << Rook.new('A8', :white)
      @white_pieces << Knight.new('B8', :white)
      @white_pieces << Bishop.new('C8', :white)
      @white_pieces << Queen.new('D8', :white)
      @white_pieces << King.new('E8', :white)
      @white_pieces << Bishop.new('F8', :white)
      @white_pieces << Knight.new('G8', :white)
      @white_pieces << Rook.new('H8', :white)

      (1..8).each do |n|
        @white_pieces << Pawn.new((64+n).chr + '7', :white)
      end

      @black_pieces << Rook.new('A1',:black)
      @black_pieces << Knight.new('B1',:black)
      @black_pieces << Bishop.new('C1',:black)
      @black_pieces << Queen.new('D1',:black)
      @black_pieces << King.new('E1',:black)
      @black_pieces << Bishop.new('F1',:black)
      @black_pieces << Knight.new('G1',:black)
      @black_pieces << Rook.new('H1',:black)

      (1..8).each do |n|
        @black_pieces << Pawn.new((64+n).chr + '2', :black)
      end

    end

end
