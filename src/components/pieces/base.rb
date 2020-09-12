# frozen_string_literal: true

module Pieces
  class Base
    attr_accessor :z, :first_move
    attr_reader :color

    def initialize(pos_x, pos_y, color)
      @x          = pos_x
      @y          = pos_y
      @z          = 1
      @first_move = true
      @color      = color
      @image      = Gosu::Image.new("media/pieces/#{@color}/#{name}.png")
    end

    def draw
      @image.draw(@x, @y, @z)
    end

    def name
      self.class.name.split('::').last.downcase
    end

    def moves
      []
    end

    def update_position(pos_x, pos_y)
      @x = pos_x
      @y = pos_y
    end
  end
end
