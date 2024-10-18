# frozen_string_literal: true

# class for the Connect Four board
class Board
  attr_reader :cells

  def initialize(cells = create)
    @cells = cells
  end

  def create(rows = 6, cols = 7)
    board = {}

    (1..rows).each do |row|
      (1..cols).each do |col|
        board[[row, col]] = ' '
      end
    end

    board
  end

  def update(col, token)
    row = 6
    row -= 1 while cells[[row, col]] == ' ' && row != 1
    cells[[row, col]] = token
  end
end
