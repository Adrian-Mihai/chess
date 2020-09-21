# frozen_string_literal: true

module Pieces
  class King < Base
    def moves
      %i[up down right left up_right up_left down_right down_left]
    end

    def move_in_loop?
      false
    end
  end
end
