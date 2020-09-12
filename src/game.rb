# frozen_string_literal: true

require_relative 'components/player'
require_relative 'components/board'
require_relative 'helpers/validates_pieces'

class Game
  include ValidatesPieces

  attr_reader :current_player, :board

  OFFSET_SELECTED_PIECE = 25
  MOVING_PIECE_ORDER    = 2
  PIECE_ORDER           = 1

  def initialize
    @white_player   = Player.new('white')
    @black_player   = Player.new('black')
    @board          = Board.new
    @current_player = @white_player
  end

  def change_current_player
    @current_player = if @current_player == @white_player
                        @black_player
                      else
                        @white_player
                      end
  end

  def select_cell(pos_x, pos_y)
    @selected_cell = nil
    cell = @board.select_cell(pos_x, pos_y)
    @selected_cell = cell if valid_piece?(cell&.piece)
    @selected_cell&.piece&.z = MOVING_PIECE_ORDER
  end

  def update_piece_position(pos_x, pos_y)
    return unless @board.in_board?(pos_x, pos_y)

    @selected_cell&.piece&.update_position(pos_x - OFFSET_SELECTED_PIECE,
                                           pos_y - OFFSET_SELECTED_PIECE)
  end

  def move_piece(pos_x, pos_y)
    return if @selected_cell.nil? || @selected_cell.piece.nil?

    cell = @board.select_cell(pos_x, pos_y)
    return if cell.nil?

    cell.piece = @selected_cell.piece
    cell.piece.update_position(cell.x, cell.y)
    cell.piece.z = PIECE_ORDER
    @selected_cell.piece = nil
  end

  def reset_piece_position
    return if @selected_cell.nil? || @selected_cell.piece.nil?

    @selected_cell.piece.update_position(@selected_cell.x, @selected_cell.y)
    @selected_cell.piece.z = PIECE_ORDER
    @selected_cell = nil
  end

  def move_piece?(pos_x, pos_y)
    return false unless @selected_cell&.piece

    cell = @board.select_cell(pos_x, pos_y)
    return false unless cell
    return false unless different_cells?(cell)
    return false unless valid_move?(current_cell: @selected_cell,
                                    new_cell: cell)

    true
  end

  private

  def valid_piece?(piece)
    same_color?(player: @current_player, piece: piece)
  end

  def different_cells?(cell)
    @selected_cell != cell
  end
end
