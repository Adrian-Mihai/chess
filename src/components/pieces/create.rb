# frozen_string_literal: true

module Pieces
  class Create
    class << self
      def call(row, col)
        return unless [0, 1, 6, 7].include?(row)

        case "#{row}:#{col}"
        when '0:0', '0:7', '7:0', '7:7'
          'Rook'
        when '0:1', '0:6', '7:1', '7:6'
          'Knight'
        when '0:2', '0:5', '7:2', '7:5'
          'Bishop'
        when '0:3', '7:3'
          'Queen'
        when '0:4', '7:4'
          'King'
        else
          'Pawn'
        end
      end
    end
  end
end
