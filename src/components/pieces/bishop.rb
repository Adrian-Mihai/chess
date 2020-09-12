# frozen_string_literal: true

module Pieces
  class Bishop < Base
    def moves
      %i[up_right up_left down_right down_left]
    end
  end
end
