require './lib/board.rb'
#
RSpec.describe Board do
#  describe "#init_pieces" do
#    it "intializes game pieces" do
#      b = Board.new
#      #expect(b.init_pieces).to eql(14)
#    end
#  end

  describe "#pos" do
    it "translates position string to board position" do
      b = Board.new
      expect(b.pos('A1')).to eql(b.board['A'][0])
    end
  end

  describe "#is_open_space?" do
    it "checks if position is occupied by another piece" do
      b = Board.new
      b.init_pieces
      expect(b.is_open_space?('A1')).to be false
      expect(b.is_open_space?('A3')).to be true
    end
  end
end
