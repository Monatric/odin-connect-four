require_relative 'displayable'

# frozen_string_literal: true

# class for the Connect Four board
class Board
  attr_reader :cells

  include Displayable

  def initialize(cells = create)
    @cells = cells
  end

  def show
    puts display_board(cells)
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
    row -= 1 while cells[[row - 1, col]] == ' ' && row != 1
    cells[[row, col]] = token
  end

  def full?
    # inverse it. If no ' ' matches, then return true/full. Otherwise false/unfull.
    !cells.value?(' ')
  end

  def full_column?(col)
    cells[[6, col]] != ' '
  end

  def game_over?(col)
    row = 6
    row -= 1 while cells[[row, col]] == ' ' && row != 1
    # get the value (token) from that key
    token = cells[[row, col]]
    scan_win_directions(row, col, token)
  end

  private

  def scan_win_directions(row, col, token)
    return true if count_vertically(row, col, token) >= 4
    return true if count_diagonally_f(row, col, token) >= 4
    return true if count_diagonally_b(row, col, token) >= 4
    return true if count_horizontally(row, col, token) >= 4

    false
  end

  def count_vertically(row, col, token)
    count = 1
    next_coord = [row - 1, col]
    while cells[next_coord] == token
      count += 1
      next_coord = [next_coord[0] - 1, next_coord[1]]
    end
    count
  end

  def count_horizontally(row, col, token)
    count = 1
    forward_coord = [row, col + 1]
    backward_coord = [row, col - 1]
    count += forward_counter(forward_coord, token, 0, 1)
    count += backward_counter(backward_coord, token, 0, -1)
    count
  end

  def count_diagonally_f(row, col, token)
    count = 1
    forward_coord = [row + 1, col + 1]
    backward_coord = [row - 1, col - 1]
    count += forward_counter(forward_coord, token, 1, 1)
    count += backward_counter(backward_coord, token, -1, -1)
    count
  end

  def count_diagonally_b(row, col, token)
    count = 1
    forward_coord = [row - 1, col + 1]
    backward_coord = [row + 1, col - 1]
    count += forward_counter(forward_coord, token, -1, 1)
    count += backward_counter(backward_coord, token, 1, -1)
    count
  end

  def backward_counter(backward_coord, token, row_change, col_change)
    count = 0
    while cells[backward_coord] == token
      count += 1
      backward_coord = [backward_coord[0] + row_change, backward_coord[1] + col_change]
    end
    count
  end

  def forward_counter(forward_coord, token, row_change, col_change)
    count = 0
    while cells[forward_coord] == token
      count += 1
      forward_coord = [forward_coord[0] + row_change, forward_coord[1] + col_change]
    end
    count
  end
end
