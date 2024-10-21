require_relative '../lib/game'
require_relative '../lib/board'

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
end
