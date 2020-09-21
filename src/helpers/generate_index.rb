# frozen_string_literal: true

require_relative 'character'

class GenerateIndex
  class << self
    def up(index)
      return if index.nil? || index.empty?

      horizontal_com = horizontal(index)
      vertical_com = vertical(index)&.next

      return if horizontal_com.nil? || vertical_com.nil?
      return if vertical_com > '8'

      "#{horizontal_com}:#{vertical_com}"
    end

    def down(index)
      return if index.nil? || index.empty?

      horizontal_com = horizontal(index)
      vertical_com = Character.predecessor(vertical(index))

      return if horizontal_com.nil? || vertical_com.nil?
      return if vertical_com < '1'

      "#{horizontal(index)}:#{vertical_com}"
    end

    def right(index)
      return if index.nil? || index.empty?

      horizontal_com = horizontal(index)&.next
      vertical_com = vertical(index)

      return if horizontal_com.nil? || vertical_com.nil?
      return if horizontal_com > 'H'

      "#{horizontal_com}:#{vertical_com}"
    end

    def left(index)
      return if index.nil? || index.empty?

      horizontal_com = Character.predecessor(horizontal(index))
      vertical_com = vertical(index)

      return if horizontal_com.nil? || vertical_com.nil?
      return if horizontal_com < 'A'

      "#{horizontal_com}:#{vertical_com}"
    end

    def up_up(index)
      up(up(index))
    end

    def down_down(index)
      down(down(index))
    end

    def up_right(index)
      right(up(index))
    end

    def down_right(index)
      right(down(index))
    end

    def up_left(index)
      left(up(index))
    end

    def down_left(index)
      left(down(index))
    end

    def up_up_right(index)
      right(up(up(index)))
    end

    def down_down_right(index)
      right(down(down(index)))
    end

    def up_up_left(index)
      left(up(up(index)))
    end

    def down_down_left(index)
      left(down(down(index)))
    end

    def right_right_up(index)
      up(right(right(index)))
    end

    def right_right_down(index)
      down(right(right(index)))
    end

    def left_left_up(index)
      up(left(left(index)))
    end

    def left_left_down(index)
      down(left(left(index)))
    end

    private

    def horizontal(index)
      return if index.nil? || index.empty?

      index.split(':').first
    end

    def vertical(index)
      return if index.nil? || index.empty?

      index.split(':').last
    end
  end
end
