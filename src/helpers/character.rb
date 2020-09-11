# frozen_string_literal: true

class Character
  class << self
    def predecessor(character)
      return if character.nil?

      character.ord.pred.chr
    end
  end
end
