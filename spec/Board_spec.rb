require "./spec/.spec_helper"

describe Board do
  
  before do
    @board = Board.construct(3,3)
  end

  it "should be able drop a coin" do
    assert @board[2,0] == '.'
    @board.drop_coin 0,'X'
    assert @board[2,0] == 'X'
  end

  it "should tell coin at position" do
    @board[0,0] = 'X'
    assert @board[0,0] == 'X'
  end

  it "should tell if column is full" do
    @board = Board[['X','.'],['X','.']]
    assert @board.column_full?(1) === false
    assert @board.column_full?(0) === true
  end

  it "should tell dimentions" do
    board = Board.construct(4,5)
    assert_equal board.width,4
    assert_equal board.height,5
  end

  it "should tell if board is full" do
    @board = Board[['X','.'],['X','O']]
    assert false == @board.full?
    @board[0,1] = 'X'
    assert @board.full?
  end

  it "should render" do
    assert @board.render == "...\n...\n...\n"
  end
end
