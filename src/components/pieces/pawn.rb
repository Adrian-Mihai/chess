# frozen_string_literal: true

module Pieces
  class Pawn < Base
    def moves
      if color == 'white'
        @first_move ? %i[up up_up] : %i[up]
      else
        @first_move ? %i[down down_down] : [:down]
      end
    end

    def move_in_loop?
      false
    end
  end
end
