# frozen_string_literal: true

class BoardIndex
  VERTICAL_VALUE      = %w[8 7 6 5 4 3 2 1].freeze
  HORIZONTAL_VALUE    = %w[A B C D E F G H].freeze
  OFFSET_VERTICAL     = 25
  OFFSET_HORIZONTAL   = 35

  def initialize
    @font = Gosu::Font.new(20)
  end

  def draw
    draw_vertical_value
    draw_horizontal_value
  end

  private

  def draw_vertical_value
    VERTICAL_VALUE.each_with_index do |value, index|
      @font.draw_text(value,
                      vertical_x_value,
                      vertical_y_value(index),
                      0,
                      1.0,
                      1.0,
                      Gosu::Color::GREEN)
    end
  end

  def vertical_x_value
    Board::OFFSET_WIDTH - OFFSET_VERTICAL
  end

  def vertical_y_value(index)
    (Board::OFFSET_HEIGHT * (index + 1))
  end

  def draw_horizontal_value
    HORIZONTAL_VALUE.each_with_index do |value, index|
      @font.draw_text(value,
                      horizontal_x_value(index),
                      horizontal_y_value,
                      0,
                      1.0,
                      1.0,
                      Gosu::Color::GREEN)
    end
  end

  def horizontal_x_value(index)
    Board::OFFSET_WIDTH * (index + 1) + OFFSET_HORIZONTAL
  end

  def horizontal_y_value
    Board::OFFSET_HEIGHT + (Board::ROW_COUNT * Board::CELL_SIZE)
  end
end
