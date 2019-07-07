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
