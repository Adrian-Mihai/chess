class Cell
  attr_accessor :piece
  attr_reader :x, :y, :index

  def initialize(x, y, index, color, piece)
    @x     = x
    @y     = y
    @index = index
    @piece = piece
    @image = Gosu::Image.new("media/board/color_#{color}.png")
  end

  def draw
    @image.draw(@x, @y, 0)
    @piece&.draw
  end

  def in_cell?(x, y)
    (@x..(@x + Board::CELL_SIZE)).include?(x) &&
      (@y..(@y + Board::CELL_SIZE)).include?(y)
  end
end
