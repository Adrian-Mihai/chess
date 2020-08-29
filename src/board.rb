require 'matrix'

require_relative 'cell'
require_relative 'board_index'
require_relative 'validates_piece_move'

require_relative 'pieces/base'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'

class Board
  attr_accessor :cells, :selected_cell

  OFFSET_WIDTH          = 50
  OFFSET_HEIGHT         = 50
  CELL_SIZE             = 50
  ROW_COUNT             = 8
  OFFSET_SELECTED_PIECE = 25

  def initialize
    @cells       = initialize_cells
    @board_index = BoardIndex.new
  end

  def draw
    @board_index.draw
    @cells.each(&:draw)
  end

  def select_cell(x, y)
    return unless in_board?(x, y)

    @selected_cell = @cells.find { |cell| cell.in_cell?(x, y) }
    return unless @selected_cell&.piece

    @selected_cell.piece.update_z_order
  end

  def update_piece_position(x, y)
    return unless in_board?(x, y)
    return unless @selected_cell&.piece

    @selected_cell.piece.x = x - OFFSET_SELECTED_PIECE
    @selected_cell.piece.y = y - OFFSET_SELECTED_PIECE
  end

  def move_piece?(x, y)
    return false unless @selected_cell&.piece

    new_cell = @cells.find { |cell| cell.in_cell?(x, y) }

    unless in_board?(x, y) && different_cells?(new_cell) && valid_move?(new_cell)
      reset_piece_position
      return false
    end

    add_piece_to(new_cell)
    @selected_cell.piece = nil
    true
  end

  private

  def initialize_cells
    Matrix.build(ROW_COUNT) do |row, col|
      Cell.new(cell_x_pos(col),
               cell_y_pos(row),
               cell_index(row, col),
               cell_color(col, row),
               cell_piece(row, col))
    end
  end

  def cell_x_pos(row)
    (row * CELL_SIZE) + OFFSET_WIDTH
  end

  def cell_y_pos(col)
    (col * CELL_SIZE) + OFFSET_HEIGHT
  end

  def cell_index(row, col)
    "#{BoardIndex::HORIZONTAL_VALUE[col]}:#{BoardIndex::VERTICAL_VALUE[row]}"
  end

  def cell_color(row, col)
    (row + col).even? ? 'w' : 'b'
  end

  def cell_piece(row, col)
    return unless [0, 1, 6, 7].include?(row)

    piece = case "#{row}:#{col}"
            when '0:0', '0:7', '7:0', '7:7'
              'Rook'
            when '0:1', '0:6', '7:1', '7:6'
              'Knight'
            when '0:2', '0:5', '7:2', '7:5'
              'Bishop'
            when '0:3', '7:3'
              'Queen'
            when '0:4', '7:4'
              'King'
            else
              'Pawn'
            end
    Pieces.const_get(piece).new(cell_x_pos(col),
                                cell_y_pos(row),
                                piece_color(row))
  end

  def piece_color(row)
    return 'black' if [0, 1].include?(row)

    'white' if [6, 7].include?(row)
  end

  def in_board?(x, y)
    (OFFSET_WIDTH..((OFFSET_WIDTH * ROW_COUNT) + CELL_SIZE)).include?(x) &&
      (OFFSET_HEIGHT..((OFFSET_HEIGHT * ROW_COUNT) + CELL_SIZE)).include?(y)
  end

  def reset_piece_position
    return unless @selected_cell&.piece

    @selected_cell.piece.x = @selected_cell.x
    @selected_cell.piece.y = @selected_cell.y
    @selected_cell.piece.reset_z_order
  end

  def add_piece_to(cell)
    return unless @selected_cell&.piece

    cell.piece   = @selected_cell.piece
    cell.piece.x = cell.x
    cell.piece.y = cell.y
    cell.piece.reset_z_order
  end

  def valid_move?(cell)
    ValidatesPieceMove.valid_move?(current_cell: @selected_cell, new_cell: cell)
  end

  def different_cells?(cell)
    @selected_cell != cell
  end
end
