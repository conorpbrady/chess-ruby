class Position
  attr_accessor :x, :y

  def initialize(x,y)
    raise Exception if x > 8 || x < 0 || y > 8 || y < 0
    @x = x
    @y = y
  end

  def occupies?(p_str)
    x = p_str[0].ord - 64
    y = p_str[1].to_i
    return x == @x && y == @y
  end
end
