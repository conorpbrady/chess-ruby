class Position
  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def occupies?(position)
    return position.x = @x && position.y == @y)
  end
end