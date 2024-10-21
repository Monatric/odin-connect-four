require_relative 'displayable'

# frozen_string_literal: true

# class for starting and setting up the game Connect Four
class Game
  attr_reader :board, :player1, :player2
  attr_accessor :current_turn, :winner

  include Displayable

  def initialize(board = Board.new, player1 = Player.new('Player 1', '♞'), player2 = Player.new('Player 2', '♝'))
    @board = board
    @player1 = player1
    @player2 = player2
    @current_turn = @player1
    @winner = nil
  end

  def drop_token(col, token)
    board.update(col, token)
    board.show
    # puts display_winner(current_turn.name) if board.game_over?(col)
  end

  def switch_turn
    self.current_turn = (current_turn == player1 ? player2 : player1)
  end

  def conclusion
    if winner.nil?
      puts 'TIE'
    else
      # puts display_winner(current_turn)
      puts "#{current_turn.name} has won the game."
    end
  end
end
