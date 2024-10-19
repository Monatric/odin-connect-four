require_relative '../lib/board'

describe Board do
  let(:token_x) { 'X' }
  describe '#update' do
    subject(:board) { described_class.new }

    context 'when the player selects an empty column' do
      it 'updates the board with a token at the very bottom of the column' do
        column_one = 1
        board.update(column_one, token_x)
        expect(board.cells[[1, 1]]).to include(token_x)
      end
    end

    context 'when the player selects a column with a token on second row' do
      let(:cells_two_rows_full) do
        {
          [1, 1] => 'X',
          [2, 1] => 'X',
          [3, 1] => ' ',
          [4, 1] => ' ',
          [5, 1] => ' ',
          [6, 1] => ' '
        }
      end
      subject(:board) { described_class.new(cells_two_rows_full) }

      it 'updates the board with a token at the third row of the column' do
        column_one = 1
        board.update(column_one, token_x)
        expect(board.cells[[3, 1]]).to include(token_x)
      end
    end
  end

  describe '#game_over?' do
    let(:col_one) { 1 }
    before do
      board.update(col_one, token_x)
    end

    context 'when the last token dropped connects a four vertically' do
      let(:cells_three_tokens) do
        {
          [1, 1] => 'X',
          [2, 1] => 'X',
          [3, 1] => 'X',
          [4, 1] => ' ',
          [5, 1] => ' ',
          [6, 1] => ' '
          # [1, 2] => ' ',
          # [2, 2] => ' ',
          # [3, 2] => ' ',
          # [4, 2] => ' ',
          # [5, 2] => ' ',
          # [6, 2] => ' '
        }
      end
      subject(:board) { described_class.new(cells_three_tokens) }

      it 'returns true' do
        result = board.game_over?(col_one)
        expect(result).to be true
      end
    end

    context 'when the last token dropped does not connect four' do
      let(:cells_two_tokens) do
        {
          [1, 1] => 'X',
          [2, 1] => 'X',
          [3, 1] => ' ',
          [4, 1] => ' ',
          [5, 1] => ' ',
          [6, 1] => ' '
        }
      end
      subject(:board) { described_class.new(cells_two_tokens) }

      it 'returns false' do
        result = board.game_over?(col_one)
        expect(result).to be false
      end
    end
  end
end
