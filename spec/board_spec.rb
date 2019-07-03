require './lib/board.rb'

RSpec.describe Board do
  describe "#init_pieces" do
    it "intializes game pieces" do
      b = Board.new
      expect(b.init_pieces).to eql(14)
    end
  end
end
