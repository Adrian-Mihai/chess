# frozen_string_literal: true

module Pieces
  class Knight < Base
    def moves
      %i[up_up_right up_up_left down_down_right down_down_left
         left_left_up left_left_down right_right_up right_right_down]
    end
  end
end
