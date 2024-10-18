require_relative '../lib/board'

describe Board do
  describe '#update' do
    let(:token_x) { 'X' }
    subject(:board) { described_class.new }

    context 'when the player selects an empty column' do
      it 'updates the board with a token at the very bottom of the column' do
        column_one = 1
        board.update(column_one, token_x)
        expect(board.cells[[1, 1]]).to include(token_x)
      end
    end

    context 'when the player selects a column with a token on second row' do
      let(:cells_full_first_row) do
        {
          [1, 1] => 'X',
          [2, 1] => 'X',
          [3, 1] => ' ',
          [4, 1] => ' ',
          [5, 1] => ' ',
          [6, 1] => ' '
        }
      end
      subject(:board) { described_class.new(cells_full_first_row) }

      it 'updates the board with a token at the third row of the column' do
        column_one = 1
        board.update(column_one, token_x)
        expect(board.cells[[3, 1]]).to include(token_x)
      end
    end
  end
end
