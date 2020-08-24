class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def name
    @color.capitalize
  end
end
