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
  end

  describe '#conclusion' do
    context 'when the game is over and player 1 wins' do
      let(:player12) { double('player1', name: 'Player 1') }
      subject(:game_over_player1_win) { described_class.new(board, player12, player2) }
      before do
        allow(game_over_player1_win).to receive(:winner).and_return(player12)
      end

      it 'displays congrats to player 1' do
        congrats_msg = "#{player12.name} has won the game."
        expect(game_over_player1_win).to receive(:puts).with(congrats_msg)
        game_over_player1_win.conclusion # TODO: works now. test the winner message
      end
    end
  end
end
