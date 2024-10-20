# frozen_string_literal: true

# class for starting and setting up the game Connect Four
class Game
  attr_reader :board, :player1, :player2
  attr_accessor :current_turn

  def initialize(board = Board.new, player1 = Player.new('1', '♠'), player2 = Player.new('2', '♣'))
    @board = board
    @player1 = player1
    @player2 = player2
    @current_turn = @player1
  end

  def switch_turn
    self.current_turn = (current_turn == player1 ? player2 : player1)
    # if current_turn == player1
    #   self.current_turn = player2
    # else
    #   self.current_turn = player1
    # end
  end
end
