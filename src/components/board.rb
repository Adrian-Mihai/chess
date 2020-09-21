# frozen_string_literal: true

require 'matrix'

require_relative 'square'
require_relative 'index'

require_relative 'pieces/create'
require_relative 'pieces/base'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'

class Board
  attr_reader :squares

  OFFSET_WIDTH  = 50
  OFFSET_HEIGHT = 50
  SQUARE_SIZE   = 50
  ROW_COUNT     = 8

  def initialize
    @squares     = initialize_squares
    @board_index = Index.new
  end

  def draw
    @board_index.draw
    @squares.each(&:draw)
  end

  def in_board?(pos_x, pos_y)
    horizontal_values.include?(pos_x) && vertical_values.include?(pos_y)
  end

  def select_square(pos_x, pos_y)
    return unless in_board?(pos_x, pos_y)

    @squares.find { |square| square.in_square?(pos_x, pos_y) }
  end

  private

  def horizontal_values
    (OFFSET_WIDTH..((OFFSET_WIDTH * ROW_COUNT) + SQUARE_SIZE))
  end

  def vertical_values
    (OFFSET_HEIGHT..((OFFSET_HEIGHT * ROW_COUNT) + SQUARE_SIZE))
  end

  def initialize_squares
    Matrix.build(ROW_COUNT) do |row, col|
      Square.new(square_x_pos(col),
                 square_y_pos(row),
                 square_index(row, col),
                 square_color(col, row),
                 square_piece(row, col))
    end
  end

  def square_x_pos(row)
    (row * SQUARE_SIZE) + OFFSET_WIDTH
  end

  def square_y_pos(col)
    (col * SQUARE_SIZE) + OFFSET_HEIGHT
  end

  def square_index(row, col)
    "#{Index::HORIZONTAL_VALUE[col]}:#{Index::VERTICAL_VALUE[row]}"
  end

  def square_color(row, col)
    (row + col).even? ? 'w' : 'b'
  end

  def square_piece(row, col)
    return unless [0, 1, 6, 7].include?(row)

    piece = Pieces::Create.call(row, col)
    Pieces.const_get(piece).new(square_x_pos(col),
                                square_y_pos(row),
                                piece_color(row))
  end

  def piece_color(row)
    return 'black' if [0, 1].include?(row)

    'white' if [6, 7].include?(row)
  end
end
