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

  describe "#check_test" do
    it "returns true if king is in check" do
      b = Board.new
      p = Rook.new('A1',:white)
      bk = King.new('A6',:black)
      wk = King.new('F8',:white)
      b.active_pieces << p
      b.active_pieces << wk << bk
      expect(b.check_test(:black)).to be true
    end

    it "returns false if king is not in check" do
      b = Board.new
      p = Rook.new('B1',:white)
      bk = King.new('A6',:black)
      wk = King.new('F8',:white)
      b.active_pieces << p << bk << wk
      expect(b.check_test(:black)).to be false
    end
  end

  describe "#available_moves" do
    it "king cannot move into check" do
      b = Board.new
      wk = King.new('B5',:white)
      bk = King.new('A8',:black)
      r = Rook.new('A1',:black)
      r2 = Rook.new('C1',:black)
      r3 = Rook.new('F6',:black)
      b.active_pieces << wk << r << r2 << r3 << bk
      expect(b.available_moves(wk).length).to eql(1)
    end

    it "another piece cannot move putting king into check" do
      b = Board.new
      wk = King.new('A5', :white)
      bk = King.new('F8',:black)
      r = Rook.new('A4', :white)
      r2 = Rook.new('A3', :black)
      b.active_pieces << wk << bk << r << r2
      expect(b.available_moves(r).length).to eql(1)
    end

    it "piece can move to block check" do
      b = Board.new
      wk = King.new('A5', :white)
      bk = King.new('F8', :black)
      r = Rook.new('A1', :black)
      r1 = Rook.new('B2', :white)
      b.active_pieces << wk << bk << r << r1

      expect(b.available_moves(r1).length).to eql(1)
    end

    it "returns two opening moves for pawn" do
      b = Board.new
      wk = King.new('F8',:white)
      bk = King.new('A1',:black)
      p = Pawn.new('A7', :white)
      b.active_pieces << wk << bk << p
      expect(b.available_moves(p).length).to eql(2)
    end

    it "returns one opening move for pawn if 2space blocked" do
      b = Board.new
      p = Pawn.new('A7', :white)
      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << p << Pawn.new('A5', :white) << wk << bk
      expect(b.available_moves(p).length).to eql(1)
    end

    it "returns no opening move for pawn if 1space blocked" do
      b = Board.new
      p = Pawn.new('A7', :white)
      b.active_pieces << p << Pawn.new('A6', :white)

      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << wk << bk
      expect(b.available_moves(p).length).to eql(0)
    end

    it "pawn can move forward one normally" do
      b = Board.new
      p = Pawn.new('A5', :white)
      p.mark_move
      b.active_pieces << p

      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << wk << bk
      expect(b.available_moves(p).length).to eql(1)
    end

    it "pawn cannot move forward if blocked" do
      b = Board.new
      p = Pawn.new('A5', :white)
      p.mark_move

      b.active_pieces << p << Pawn.new('A4', :black)

      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << wk << bk
      expect(b.available_moves(p).length).to eql(0)
    end

    it "pawn can move diagonal to capture" do
      b = Board.new
      p = Pawn.new('A5', :white)
      p.mark_move

      b.active_pieces << p
      b.active_pieces << Pawn.new('A4', :white)
      b.active_pieces << Pawn.new('B4', :black)

      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << wk << bk
      expect(b.available_moves(p).length).to eql(1)
    end

    it "returns 28 moves for Queen empty board" do
      b = Board.new
      p = Queen.new('D4', :white)
      b.active_pieces << p << King.new('F8', :white)
      expect(b.available_moves(p).length).to eql(27)
    end

    it "returns 8 moves for Knight empty board" do
      b = Board.new
      p = Knight.new('D4', :white)
      b.active_pieces << p

      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << wk << bk
      expect(b.available_moves(p).length).to eql(8)
    end

    it "returns 8 moves for King empty board" do
      b = Board.new
      p = King.new('D4', :white)
      b.active_pieces << p
      expect(b.available_moves(p).length).to eql(8)
    end

    it "Rook can capture piece more than 1 space away" do
      b = Board.new
      r = Rook.new('A1', :white)
      k = Knight.new('B1', :white)
      p = Pawn.new('A7',:black)
      b.active_pieces << r << k << p

      wk = King.new('F8', :white)
      bk = King.new('F6', :black)
      b.active_pieces << wk << bk
      expect(b.available_moves(r).length).to eql(6)
    end

  end

end
