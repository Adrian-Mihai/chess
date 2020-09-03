# frozen_string_literal: true

class ValidatesPieceMove
  class << self
    def valid?(current_cell:, new_cell:)
      return false if current_cell&.piece&.color == new_cell&.piece&.color

      true
    end

    def valid_piece?(player:, piece:)
      return false if player.color != piece&.color

      true
    end
  end
end
