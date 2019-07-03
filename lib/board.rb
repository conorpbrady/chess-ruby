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

  end

  def is_open_space?(position)
    @white_pieces.each { |piece| return false if piece.position.occupies?(pos(position)) }
    @black_pieces.each { |piece| return false if piece.position.occupies?(pos(position)) }
    return true
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
      @white_pieces << Rook.new(pos('A1'))
      @white_pieces << Knight.new(pos('B1'))
      @white_pieces << Bishop.new(pos('C1'))
      @white_pieces << Queen.new(pos('D1'))
      @white_pieces << King.new(pos('E1'))
      @white_pieces << Bishop.new(pos('F1'))
      @white_pieces << Knight.new(pos('G1'))
      @white_pieces << Rook.new(pos('H1'))

    end

end
