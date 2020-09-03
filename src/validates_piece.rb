# frozen_string_literal: true

class ValidatesPiece
  class << self
    def valid_move?(current_cell:, new_cell:)
      return false if current_cell.nil? || new_cell.nil?
      return false if current_cell.piece&.color == new_cell.piece&.color

      true
    end

    def same_color?(player:, piece:)
      return false if player.nil? || piece.nil?
      return false if player.color != piece.color

      true
    end
  end
end
