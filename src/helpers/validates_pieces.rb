# frozen_string_literal: true

require_relative 'generate_moves'

module ValidatesPieces
  def valid_move?(board, current_square, new_square)
    return false if board.nil? || current_square.nil? || new_square.nil?

    moves = GenerateMoves.call(board,
                               current_square.piece,
                               current_square.index)
    return false unless moves.include?(new_square.index)

    true
  end

  def same_color?(player, piece)
    return false if player.nil? || piece.nil?
    return false if player.color != piece.color

    true
  end
end
