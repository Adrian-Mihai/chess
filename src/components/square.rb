# frozen_string_literal: true

class Square
  attr_accessor :piece
  attr_reader :x, :y, :index

  def initialize(pos_x, pos_y, index, color, piece)
    @x     = pos_x
    @y     = pos_y
    @index = index
    @piece = piece
    @image = Gosu::Image.new("media/board/color_#{color}.png")
  end

  def draw
    @image.draw(@x, @y, 0)
    @piece&.draw
  end

  def in_square?(pos_x, pos_y)
    (@x..(@x + Board::SQUARE_SIZE)).include?(pos_x) &&
      (@y..(@y + Board::SQUARE_SIZE)).include?(pos_y)
  end
end
