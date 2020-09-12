# frozen_string_literal: true

module Pieces
  class Pawn < Base
    def moves
      @first_move ? %i[up up] : %i[up]
    end
  end
end
