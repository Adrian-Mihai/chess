#!/usr/bin/env ruby

require 'gosu'

require_relative 'src/game'

class Chess < Gosu::Window
  WIDTH  = 500
  HEIGHT = 500

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Chess'

    @game = Game.new
    @font = Gosu::Font.new(20)
  end

  def draw
    @font.draw_text("Player: #{@game.current_player.name}",
                    0, 0, 0, 1.0, 1.0, Gosu::Color::GREEN)
    @game.board.draw
  end

  def update
    return unless in_game?
    return unless Gosu.button_down?(Gosu::MS_LEFT)

    @game.update_piece_position(mouse_x, mouse_y)
  end

  def button_down(id)
    case id
    when Gosu::MS_LEFT
      return unless in_game?

      @game.select_square(mouse_x, mouse_y)
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def button_up(id)
    case id
    when Gosu::MS_LEFT
      move_piece
    else
      super
    end
  end

  def needs_cursor?
    true
  end

  private

  def in_game?
    (0..WIDTH).include?(mouse_x) && (0..HEIGHT).include?(mouse_y)
  end

  def move_piece
    return @game.reset_piece_position unless @game.move_piece?(mouse_x, mouse_y)

    @game.move_piece(mouse_x, mouse_y)
    @game.change_current_player
  end
end

Chess.new.show
