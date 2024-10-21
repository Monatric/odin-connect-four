require_relative 'board'
require_relative 'game'
require_relative 'player'
require_relative 'displayable'

game = Game.new

def start(game)
  puts 'Welcome to Connect Four!'
  game.board.show
  select_column(game)
end

def select_column(game)
  until game.board.full?
    puts "#{game.current_turn.name} turn."
    print 'Select a column to drop the token: '

    user_input = gets.chomp
    user_input = verify_input(user_input, game)

    game.drop_token(user_input, game.current_turn.token)
    break if game.board.game_over?(user_input)
  end
end

def verify_input(input, game)
  until input.match?(/\A[1-7]\z/) && !game.board.full_column?(input.to_i)
    print 'Invalid choice. Try again: '
    input = gets.chomp
  end
  input.to_i
end

start(game)
