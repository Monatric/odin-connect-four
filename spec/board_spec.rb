require_relative '../lib/board'

describe Board do
  let(:token_x) { 'X' }
  let(:col_one) { 1 }
  let(:col_two) { 2 }
  let(:col_three) { 3 }
  let(:col_four) { 4 }

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
    context 'when the last token dropped connects a four vertically' do
      let(:cells_three_tokens) do
        {
          [1, 1] => 'X',
          [2, 1] => 'X',
          [3, 1] => 'X',
          [4, 1] => ' ',
          [5, 1] => ' ',
          [6, 1] => ' '
        }
      end
      subject(:board_three_tokens) { described_class.new(cells_three_tokens) }
      before do
        board_three_tokens.update(col_one, token_x)
      end

      it 'returns true' do
        result = board_three_tokens.game_over?(col_one)
        expect(result).to be true
      end
    end

    context 'when the last token dropped connects a four horizontally' do
      context 'when the last token dropped at right edge' do
        let(:cells_three_tokens) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => ' ',
            [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O', [2, 4] => ' ',
            [1, 1] => 'X', [1, 2] => 'X', [1, 3] => 'X', [1, 4] => ' '
          }
        end
        subject(:board_three_tokens) { described_class.new(cells_three_tokens) }
        before do
          board_three_tokens.update(col_four, token_x)
        end

        it 'returns true' do
          result = board_three_tokens.game_over?(col_four)
          expect(result).to be true
        end
      end

      context 'when the last token dropped at left edge' do
        let(:cells_three_tokens) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => ' ', [1, 2] => 'X', [1, 3] => 'X', [1, 4] => 'X'
          }
        end
        subject(:board_three_tokens) { described_class.new(cells_three_tokens) }
        before do
          board_three_tokens.update(col_one, token_x)
        end

        it 'returns true' do
          result = board_three_tokens.game_over?(col_one)
          expect(result).to be true
        end
      end

      context 'when the last token dropped at middle' do
        let(:cells_three_tokens) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => 'X', [1, 2] => ' ', [1, 3] => 'X', [1, 4] => 'X'
          }
        end
        subject(:board_three_tokens) { described_class.new(cells_three_tokens) }
        before do
          board_three_tokens.update(col_two, token_x)
        end

        it 'returns true' do
          result = board_three_tokens.game_over?(col_two)
          expect(result).to be true
        end
      end
    end

    context 'when the last token dropped connects four diagonally forward' do
      context 'when the last token dropped at right edge' do
        let(:cells_three_tokens_diag_f) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => 'X', [2, 2] => 'X', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => 'X', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => 'O'
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_three_tokens_diag_f) }
        before do
          board_diagonal_tokens.update(col_four, token_x)
        end

        it 'returns true' do
          result = board_diagonal_tokens.game_over?(col_four)
          expect(result).to be true
        end
      end

      context 'when the last token dropped at left edge' do
        let(:cells_three_tokens_diag_f) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => 'X',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => ' ', [2, 2] => 'X', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => ' ', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => 'O'
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_three_tokens_diag_f) }
        before do
          board_diagonal_tokens.update(col_one, token_x)
        end

        it 'returns true' do
          result = board_diagonal_tokens.game_over?(col_one)
          expect(result).to be true
        end
      end

      context 'when the last token dropped at middle' do
        let(:cells_three_tokens_diag_f) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => 'X',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => 'X', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => 'O'
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_three_tokens_diag_f) }
        before do
          board_diagonal_tokens.update(col_two, token_x)
        end

        it 'returns true' do
          result = board_diagonal_tokens.game_over?(col_two)
          expect(result).to be true
        end
      end
    end

    context 'when the last token dropped connects four diagonally backward' do
      context 'when the last token dropped at right edge' do
        let(:cells_three_tokens_diag_b) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => 'X', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => 'O', [3, 2] => 'X', [3, 3] => ' ', [3, 4] => ' ',
            [2, 1] => 'X', [2, 2] => 'O', [2, 3] => 'X', [2, 4] => ' ',
            [1, 1] => 'X', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => ' '
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_three_tokens_diag_b) }
        before do
          board_diagonal_tokens.update(col_four, token_x)
        end

        it 'returns true' do
          result = board_diagonal_tokens.game_over?(col_four)
          expect(result).to be true
        end
      end

      context 'when the last token dropped at left edge' do
        let(:cells_three_tokens_diag_f) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => 'O', [3, 2] => 'X', [3, 3] => ' ', [3, 4] => ' ',
            [2, 1] => 'X', [2, 2] => 'O', [2, 3] => 'X', [2, 4] => ' ',
            [1, 1] => 'X', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => 'X'
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_three_tokens_diag_f) }
        before do
          board_diagonal_tokens.update(col_one, token_x)
        end

        it 'returns true' do
          result = board_diagonal_tokens.game_over?(col_one)
          expect(result).to be true
        end
      end

      context 'when the last token dropped at middle' do
        let(:cells_three_tokens_diag_f) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => 'X', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => 'O', [3, 2] => ' ', [3, 3] => ' ', [3, 4] => ' ',
            [2, 1] => 'X', [2, 2] => 'O', [2, 3] => 'X', [2, 4] => ' ',
            [1, 1] => 'X', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => 'X'
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_three_tokens_diag_f) }
        before do
          board_diagonal_tokens.update(col_two, token_x)
        end

        it 'returns true' do
          result = board_diagonal_tokens.game_over?(col_two)
          expect(result).to be true
        end
      end
    end

    context 'when the last token dropped does not connect four' do
      context 'when the vertical pattern is short' do
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
        subject(:board_two_tokens) { described_class.new(cells_two_tokens) }
        before do
          board_two_tokens.update(col_one, token_x)
        end

        it 'returns false' do
          result = board_two_tokens.game_over?(col_one)
          expect(result).to be false
        end
      end

      context 'when the horizontal pattern is short' do
        let(:cells_two_tokens) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => ' ', [1, 2] => ' ', [1, 3] => 'X', [1, 4] => 'X'
          }
        end
        subject(:board_horizontal_tokens) { described_class.new(cells_two_tokens) }
        before do
          board_horizontal_tokens.update(col_two, token_x)
        end

        it 'returns false' do
          result = board_horizontal_tokens.game_over?(col_two)
          expect(result).to be false
        end
      end

      context 'when the diagonal forward pattern is short' do
        let(:cells_two_tokens_diag_f) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => ' ', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => 'X',
            [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X', [3, 4] => 'O',
            [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O', [2, 4] => 'O',
            [1, 1] => ' ', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => 'O'
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_two_tokens_diag_f) }
        before do
          board_diagonal_tokens.update(col_two, token_x)
        end

        it 'returns false' do
          result = board_diagonal_tokens.game_over?(col_two)
          expect(result).to be false
        end
      end

      context 'when the diagonal backward pattern is short' do
        let(:cells_two_tokens_diag_b) do
          {
            [6, 1] => ' ', [6, 2] => ' ', [6, 3] => ' ', [6, 4] => ' ',
            [5, 1] => ' ', [5, 2] => ' ', [5, 3] => ' ', [5, 4] => ' ',
            [4, 1] => 'X', [4, 2] => ' ', [4, 3] => ' ', [4, 4] => ' ',
            [3, 1] => 'O', [3, 2] => ' ', [3, 3] => ' ', [3, 4] => ' ',
            [2, 1] => 'X', [2, 2] => 'O', [2, 3] => 'X', [2, 4] => ' ',
            [1, 1] => 'X', [1, 2] => 'O', [1, 3] => 'O', [1, 4] => ' '
          }
        end
        subject(:board_diagonal_tokens) { described_class.new(cells_two_tokens_diag_b) }
        before do
          board_diagonal_tokens.update(col_two, token_x)
        end

        it 'returns false' do
          result = board_diagonal_tokens.game_over?(col_two)
          expect(result).to be false
        end
      end
    end
  end

  describe '#full?' do
    context 'when the board is full' do
      let(:full_cells) do
        {
          [2, 1] => 'X', [2, 2] => 'O',
          [1, 1] => 'O', [1, 2] => 'X'
        }
      end
      subject(:board) { described_class.new(full_cells) }

      it 'returns true' do
        expect(board).to be_full
      end
    end

    context 'when the board is full' do
      let(:not_full_cells) do
        {
          [2, 1] => ' ', [2, 2] => 'O',
          [1, 1] => 'O', [1, 2] => 'X'
        }
      end
      subject(:board) { described_class.new(not_full_cells) }

      it 'returns false' do
        expect(board).not_to be_full
      end
    end
  end

  describe '#full_column?' do
    let(:three_columns) do
      {
        [6, 1] => ' ', [6, 2] => ' ', [6, 3] => 'O',
        [5, 1] => ' ', [5, 2] => ' ', [5, 3] => 'X',
        [4, 1] => ' ', [4, 2] => ' ', [4, 3] => 'O',
        [3, 1] => ' ', [3, 2] => ' ', [3, 3] => 'X',
        [2, 1] => ' ', [2, 2] => ' ', [2, 3] => 'O',
        [1, 1] => 'X', [1, 2] => 'X', [1, 3] => 'X'

      }
    end
    subject(:board_three_columns) { described_class.new(three_columns) }

    context 'when the selected column is full' do
      it 'returns true' do
        result = board_three_columns.full_column?(col_three)
        expect(result).to be true
      end
    end

    context 'when the selected column is not full' do
      it 'returns false' do
        result = board_three_columns.full_column?(col_one)
        expect(result).to be false
      end
    end
  end
end
