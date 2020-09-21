# frozen_string_literal: true

require_relative 'generate_index'

class GenerateMoves
  def self.call(board, piece, index)
    new(board, piece, index).call
  end

  def initialize(board, piece, index)
    @board = board
    @piece = piece
    @index = index
  end

  def call
    return if @board.nil? || @piece.nil? || @index.nil? || @index.empty?

    moves = if @piece.move_in_loop?
              @piece.moves.map { |move| index_in_loop_from(move) }
            else
              @piece.moves.map { |move| index_from(move) }
            end

    moves.flatten.compact
  end

  private

  def index_in_loop_from(move)
    return unless GenerateIndex.respond_to?(move)

    possible_moves = []
    generated_index = GenerateIndex.public_send(move, @index)
    while vacant_cell?(generated_index)
      possible_moves << generated_index
      generated_index = GenerateIndex.public_send(move, generated_index)
    end
    possible_moves << generated_index if different_color?(generated_index)
    possible_moves
  end

  def index_from(move)
    return unless GenerateIndex.respond_to?(move)

    generated_index = GenerateIndex.public_send(move, @index)
    if vacant_cell?(generated_index)
      generated_index
    else
      different_color?(generated_index) ? generated_index : nil
    end
  end

  def vacant_cell?(index)
    return false if index.nil?

    new_cell = @board.cells.find { |cell| cell.index == index }
    return false if new_cell.nil? || new_cell.piece

    true
  end

  def different_color?(index)
    return false if index.nil?

    new_cell = @board.cells.find { |cell| cell.index == index }
    @piece.color != new_cell&.piece&.color
  end
end
