require "./spec/.spec_helper"

describe Board do

  it "should be able drop a coin" do
    @board = Board.construct(3,3)
    assert @board[0,2] == '.'
    @board.drop_coin 0,'X'
    @board.drop_coin 1,'O'
    assert @board[0,2] == 'X'
    assert @board[1,2] == 'O'
  end

  it "should tell coin at position" do
    @board = Board[['_','_'],['O','_']]
    @board[1,0] = 'X'
    assert @board[1,0] == 'X'
    assert @board[0,1] == 'O'
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
    @board[1,0] = 'X'
    assert @board.full?
  end

  it "should clone" do
    @board = Board[['1','1'],['1','1']]
    @board2 = @board.clone
    @board2[0,0] = '2'
    assert @board[0,0] == '1'
    assert @board2[0,0] == '2'
  end

  it "should render" do
    @board = Board[['X','.','.'],
                   ['X','O','O'],
                   ['O','X','X']]
    assert @board.render == "X..\nXOO\nOXX\n"
  end
end
