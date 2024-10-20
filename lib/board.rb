# frozen_string_literal: true

# class for the Connect Four board
class Board
  attr_reader :cells

  def initialize(cells = create)
    @cells = cells
  end

  # rubocop:disable Metrics/AbcSize
  def show # rubocop:disable Metrics/MethodLength
    puts <<-HEREDOC
      1   2   3   4   5   6   7
    | #{cells[[6, 1]]} | #{cells[[6, 2]]} | #{cells[[6, 3]]} | #{cells[[6, 4]]} | #{cells[[6, 5]]} | #{cells[[6, 6]]} | #{cells[[6, 7]]} |
    +---+---+---+---+---+---+---+
    | #{cells[[5, 1]]} | #{cells[[5, 2]]} | #{cells[[5, 3]]} | #{cells[[5, 4]]} | #{cells[[5, 5]]} | #{cells[[5, 6]]} | #{cells[[5, 7]]} |
    +---+---+---+---+---+---+---+
    | #{cells[[4, 1]]} | #{cells[[4, 2]]} | #{cells[[4, 3]]} | #{cells[[4, 4]]} | #{cells[[4, 5]]} | #{cells[[4, 6]]} | #{cells[[4, 7]]} |
    +---+---+---+---+---+---+---+
    | #{cells[[3, 1]]} | #{cells[[3, 2]]} | #{cells[[3, 3]]} | #{cells[[3, 4]]} | #{cells[[3, 5]]} | #{cells[[3, 6]]} | #{cells[[3, 7]]} |
    +---+---+---+---+---+---+---+
    | #{cells[[2, 1]]} | #{cells[[2, 2]]} | #{cells[[2, 3]]} | #{cells[[2, 4]]} | #{cells[[2, 5]]} | #{cells[[2, 6]]} | #{cells[[2, 7]]} |
    +---+---+---+---+---+---+---+
    | #{cells[[1, 1]]} | #{cells[[1, 2]]} | #{cells[[1, 3]]} | #{cells[[1, 4]]} | #{cells[[1, 5]]} | #{cells[[1, 6]]} | #{cells[[1, 7]]} |
    +---+---+---+---+---+---+---+

    HEREDOC
  end
  # rubocop:enable Metrics/AbcSize

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
    next_backward_coord = [row, col - 1]
    next_forward_coord = [row, col + 1]
    while cells[next_backward_coord] == token
      count += 1
      next_backward_coord = [next_backward_coord[0], next_backward_coord[1] - 1]
    end
    while cells[next_forward_coord] == token
      count += 1
      next_forward_coord = [next_forward_coord[0], next_forward_coord[1] + 1]
    end
    count
  end

  def count_diagonally_f(row, col, token)
    count = 1
    next_backward_coord = [row - 1, col - 1]
    next_forward_coord = [row + 1, col + 1]
    while cells[next_backward_coord] == token
      count += 1
      next_backward_coord = [next_backward_coord[0] - 1, next_backward_coord[1] - 1]
    end
    while cells[next_forward_coord] == token
      count += 1
      next_forward_coord = [next_forward_coord[0] + 1, next_forward_coord[1] + 1]
    end
    count
  end

  def count_diagonally_b(row, col, token)
    count = 1
    next_backward_coord = [row + 1, col - 1]
    next_forward_coord = [row - 1, col + 1]
    while cells[next_backward_coord] == token
      count += 1
      next_backward_coord = [next_backward_coord[0] + 1, next_backward_coord[1] - 1]
    end
    while cells[next_forward_coord] == token
      count += 1
      next_forward_coord = [next_forward_coord[0] - 1, next_forward_coord[1] + 1]
    end
    count
  end
end
