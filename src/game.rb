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

  def select_square(pos_x, pos_y)
    @selected_square = nil
    square = @board.select_square(pos_x, pos_y)
    @selected_square = square if same_color?(@current_player, square&.piece)
    @selected_square&.piece&.z = MOVING_PIECE_ORDER
  end

  def update_piece_position(pos_x, pos_y)
    return unless @board.in_board?(pos_x, pos_y)

    @selected_square&.piece&.update_position(pos_x - OFFSET_SELECTED_PIECE,
                                             pos_y - OFFSET_SELECTED_PIECE)
  end

  def move_piece(pos_x, pos_y)
    return if @selected_square.nil? || @selected_square.piece.nil?

    square = @board.select_square(pos_x, pos_y)
    return if square.nil?

    square.piece = @selected_square.piece
    square.piece.update_position(square.x, square.y)
    square.piece.z = PIECE_ORDER
    square.piece.first_move = false
    @selected_square.piece = nil
  end

  def reset_piece_position
    return if @selected_square.nil? || @selected_square.piece.nil?

    @selected_square.piece.update_position(@selected_square.x,
                                           @selected_square.y)
    @selected_square.piece.z = PIECE_ORDER
    @selected_square = nil
  end

  def move_piece?(pos_x, pos_y)
    return false unless @selected_square&.piece

    square = @board.select_square(pos_x, pos_y)
    return false unless square
    return false unless valid_move?(@board, @selected_square, square)

    true
  end
end
