class Move
  attr_accessor :piece, :from, :to, :capture

  def initialize(piece, from, to, capture)
    @piece = piece
    @from = from
    @to = to
    @capture = capture
  end

  def to_s
    return "#{@piece} from: #{@from} to: #{@to}"
  end
end
