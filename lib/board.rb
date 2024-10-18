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
    # subtract row to 1 to scan for the spot on which the token is supposed to land
    while cells[[row - 1, col]] == ' '
      row -= 1
      break if row == 1
    end
    cells[[row, col]] = token
  end
end
