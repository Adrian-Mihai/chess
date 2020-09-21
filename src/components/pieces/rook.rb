# frozen_string_literal: true

module Pieces
  class Rook < Base
    def moves
      %i[up down right left]
    end
  end
end
