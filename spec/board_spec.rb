require './lib/board.rb'

#
RSpec.describe Board do

  describe "#get_piece_at" do
    it "returns piece at (x,y) position" do
      b = Board.new
      b.init_pieces
      expect(b.get_piece_at(1,2).class).to eql(Pawn)
      expect(b.get_piece_at(1,1).class).to eql(Rook)
    end
  end



  describe "#available_moves" do
    it "returns two opening moves for pawn" do
      b = Board.new
      p = Pawn.new('A7', :white)
      expect(b.available_moves(p).length).to eql(2)
    end
    it "returns one opening move for pawn if blocked" do
      b = Board.new
      p = Pawn.new('A7', :white)
      b.active_pieces << p
      b.active_pieces << Pawn.new('A5', :white)
      expect(b.available_moves(p).length).to eql(1)
    end
    it "returns no opening move for pawn if blocked" do
      b = Board.new
      p = Pawn.new('A7', :white)
      b.active_pieces << p
      b.active_pieces << Pawn.new('A6', :white)
      b.available_moves(p).each { |k,v| p v.to_s }
      expect(b.available_moves(p).length).to eql(0)
    end

    it "pawn can move forward one normally" do
      b = Board.new
      p = Pawn.new('A5', :white)
      p.mark_move
      expect(b.available_moves(p).length).to eql(1)
    end

    it "pawn cannot move forward if blocked" do
      b = Board.new
      p = Pawn.new('A5', :white)
      p.mark_move

      b.active_pieces << p
      b.active_pieces << Pawn.new('A4', :black)

      expect(b.available_moves(p).length).to eql(0)
    end

    it "pawn can move diagonal to capture" do
      b = Board.new
      p = Pawn.new('A5', :white)
      p.mark_move

      b.active_pieces << p
      b.active_pieces << Pawn.new('A4', :white)
      b.active_pieces << Pawn.new('B4', :black)

      expect(b.available_moves(p).length).to eql(1)
    end

    it "returns 28 moves for Queen empty board" do
      b = Board.new
      p = Queen.new('D4', :white)
      expect(b.available_moves(p).length).to eql(27)
    end

    it "returns 8 moves for Knight empty board" do
      b = Board.new
      p = Knight.new('D4', :white)
      expect(b.available_moves(p).length).to eql(8)
    end

    it "returns 8 moves for King empty board" do
      b = Board.new
      p = King.new('D4', :white)
      expect(b.available_moves(p).length).to eql(8)
    end

  end

end
