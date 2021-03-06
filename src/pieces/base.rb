module Pieces
  class Base
    attr_accessor :x, :y
    attr_reader :color

    def initialize(x, y, color)
      @x          = x
      @y          = y
      @z          = 1
      @color      = color
      @image      = Gosu::Image.new("media/pieces/#{@color}/#{name}.png")
    end

    def draw
      @image.draw(@x, @y, @z)
    end

    def name
      self.class.name.split('::').last.downcase
    end

    def update_z_order
      @z = 2
    end

    def reset_z_order
      @z = 1
    end
  end
end
