# module for displaying CLI messages
module Displayable
  def display_winner(player)
    "#{player} has won the game."
  end

  def display_tie
    "No player won. It's a tie."
  end

  def display_board(cells) # rubocop:disable Metrics/AbcSize
    <<-HEREDOC
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
end
