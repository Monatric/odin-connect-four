require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
  let(:player1) { double('player1') }
  let(:player2) { double('player2') }
  let(:board) { instance_double(Board) }

  describe '#switch_turn' do
    context 'when the current_turn is Player 1' do
      subject(:game) { described_class.new(board, player1, player2) }

      it 'changes to Player 2 on next turn' do
        game.switch_turn
        expect(game.current_turn).to be player2
      end
    end

    context 'when the current_turn is Player 2' do
      subject(:game) { described_class.new(board, player1, player2) }

      before do
      end

      it 'changes to Player 1 on next turn' do
        game.switch_turn
        game.switch_turn

        expect(game.current_turn).to be player1
      end
    end
  end

  describe '#conclusion' do
    let(:player1_with_name) { double('player1', name: 'Player 1') }
    let(:player2_with_name) { double('player2', name: 'Player 2') }
    subject(:game_over_player1_win) { described_class.new(board, player1_with_name, player2_with_name) }
    context 'when the game is over and player 1 wins' do
      before do
        allow(game_over_player1_win).to receive(:winner).and_return(player1_with_name)
      end

      it 'displays congrats to player 1' do
        congrats_msg = "#{player1_with_name.name} has won the game."
        expect(game_over_player1_win).to receive(:puts).with(congrats_msg)
        game_over_player1_win.conclusion
      end
    end
  end
end
