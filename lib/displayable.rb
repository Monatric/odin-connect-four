# module for displaying CLI messages
module Displayable
  def display_winner(player)
    "#{player} has won the game."
  end

  def display_tie
    "No player won. It's a tie."
  end
end
