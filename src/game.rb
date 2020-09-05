# frozen_string_literal: true

require_relative 'components/player'
require_relative 'components/board'
require_relative 'helpers/validates_pieces'

class Game
  attr_reader :current_player, :board

  OFFSET_SELECTED_PIECE = 25

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
    @selected_cell&.piece&.update_z_order
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
    cell.piece.reset_z_order
    @selected_cell.piece = nil
  end

  def reset_piece_position
    return if @selected_cell.nil? || @selected_cell.piece.nil?

    @selected_cell.piece.update_position(@selected_cell.x, @selected_cell.y)
    @selected_cell.piece.reset_z_order
    @selected_cell = nil
  end

  def move_piece?(pos_x, pos_y)
    return false unless @selected_cell&.piece

    new_cell = @board.select_cell(pos_x, pos_y)
    return false unless new_cell
    return false unless valid_move?(new_cell)

    true
  end

  private

  def valid_piece?(piece)
    ValidatesPieces.same_color?(player: @current_player, piece: piece)
  end

  def valid_move?(cell)
    different_cells?(cell) &&
      ValidatesPieces.valid_move?(current_cell: @selected_cell, new_cell: cell)
  end

  def different_cells?(cell)
    @selected_cell != cell
  end
end
