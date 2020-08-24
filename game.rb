#!/usr/bin/env ruby

require 'gosu'

require_relative './src/board'
require_relative './src/player'

class Chess < Gosu::Window
  WIDTH  = 500
  HEIGHT = 500

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Chess'

    @black_player   = Player.new('black')
    @white_player   = Player.new('white')
    @current_player = @white_player
    @board          = Board.new
    @font           = Gosu::Font.new(20)
  end

  def update
    return unless Gosu.button_down?(Gosu::MS_LEFT)
    return unless in_game?

    @board.update_piece_position(mouse_x, mouse_y)
  end

  def draw
    @font.draw_text("Player: #{@current_player.name}",
                    0, 0, 0, 1.0, 1.0, Gosu::Color::GREEN)
    @board.draw
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::MS_LEFT
      return unless in_game?

      @board.select_cell(mouse_x, mouse_y)
      @board.selected_cell = nil unless valid_piece?
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def button_up(id)
    if id == Gosu::MS_LEFT
      if @board.move_piece?(mouse_x, mouse_y)
        @current_player = change_current_player
      end
    else
      super
    end
  end

  private

  def in_game?
    (0..WIDTH).include?(mouse_x) && (0..HEIGHT).include?(mouse_y)
  end

  def valid_piece?
    @current_player.color == @board.selected_cell&.piece&.color
  end

  def change_current_player
    @current_player == @white_player ? @black_player : @white_player
  end
end

Chess.new.show
