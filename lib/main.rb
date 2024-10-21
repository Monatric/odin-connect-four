require_relative 'board'
require_relative 'game'
require_relative 'player'
require_relative 'displayable'

game = Game.new

def start(game)
  puts 'Welcome to Connect Four!'
  game.board.show
  select_column(game)
  game.conclusion
end

def select_column(game)
  until game.board.full?
    puts "#{game.current_turn.name} turn."
    user_input = take_input(game)

    game.drop_token(user_input, game.current_turn.token)
    if game.board.game_over?(user_input)
      game.winner = game.current_turn
      break
    end

    game.switch_turn
  end
end

def take_input(game)
  print 'Select a column to drop the token: '

  user_input = gets.chomp
  verify_input(user_input, game)
end

def verify_input(input, game)
  until input.match?(/\A[1-7]\z/) && !game.board.full_column?(input.to_i)
    print 'Invalid choice. Try again: '
    input = gets.chomp
  end
  input.to_i
end

start(game)
