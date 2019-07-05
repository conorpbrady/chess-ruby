class Position
  attr_accessor :x, :y

  def initialize(x,y)
    raise Exception if x > 8 || x < 0 || y > 8 || y < 0
    @x = x
    @y = y
  end

  def to_s
    return "#{(@x+64).chr}#{y}"
  end
end
