require "./spec/.spec_helper"

describe AI do

  before do
    @ai = AI.new 
  end

  it "should decide next turn" do
  end

  # here: evaluate based on col+1 per coin
  it "should compute evaluate from board" do
    @board = Board[['X','O'],['X','O']]
    assert_equal 0,@ai.evaluate(@board)
  end

  # here: is board full?
  it "should tell if state is cut_off" do
    @board = Board[['.','O'],['X','O']]
    assert_equal false,@ai.cut_off?(@board,0)
    @board = Board[['X','O'],['X','O']]
    assert_equal true,@ai.cut_off?(@board,0)
  end

  it "should give possible actions" do
    @board = Board[['.','O','.'],
                   ['.','X','O']]
    assert @ai.actions(@board) == [0,2]
  end

  it "should be tested" do
    @board = Board[['.','.','.','.','.','.','.'],
                   ['.','.','.','.','.','.','.'],
                   ['.','.','.','.','.','.','.'],
                   ['.','.','.','.','.','.','.'],
                   ['.','.','.','.','.','.','.'],
                   ['.','.','.','.','.','.','.']]
    m = @ai.minimax(@board)
    puts "RESULT #{m[0]}, TO GO: #{m[1]}"
  end

  it "should report best line" do
  end

end
