require "./spec/.spec_helper"

describe AI do

  before do
    @ai = AI.new 
  end

  it "should decide next turn" do
  end

  # here: utility based on col+1 per coin
  it "should compute utility from board" do
    @board = Board[['.','O'],['.','O']]
    assert_equal 4,@ai.utility(@board)
  end

  # here: is board full?
  it "should tell if state is terminal" do
    @board = Board[['.','O'],['X','O']]
    assert_equal false,@ai.terminal?(@board)
    @board = Board[['X','O'],['X','O']]
    assert_equal true,@ai.terminal?(@board)
  end

  it "should give possible actions" do
    @board = Board[['.','O','.'],
                   ['.','X','O']]
    assert @ai.actions(@board) == [0,2]
  end

  it "should be tested" do
    @board = Board[['.','.','.'],
                   ['.','.','.']]
    puts "#{@ai.minimax @board}"
  end

  it "should be able to clone" do
    @board = Board[['1','1'],['1','1']]
    @board2 = @board.clone
    @board2[0,0] = '2'
    assert @board[0,0] == '1'
    assert @board2[0,0] == '2'
  end

end
