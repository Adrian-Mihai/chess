# frozen_string_literal: true

module Pieces
  class Queen < Base
    def moves
      %i[up down right left up_right up_left down_right down_left]
    end
  end
end
