# frozen_string_literal: true

require_relative 'generate_moves'

module ValidatesPieces
  def valid_move?(board, current_cell, new_cell)
    return false if board.nil? || current_cell.nil? || new_cell.nil?

    moves = GenerateMoves.call(board, current_cell.piece, current_cell.index)
    return false unless moves.include?(new_cell.index)

    true
  end

  def same_color?(player, piece)
    return false if player.nil? || piece.nil?
    return false if player.color != piece.color

    true
  end
end
