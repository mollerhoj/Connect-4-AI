require "./spec/.spec_helper"

describe Referee do

  before do
    @referee = Referee.new
  end

  it "should give a row score to a row of a board" do
    board = Board[['O','.','.','.','.']]
    assert @referee.row_score(0,board) == 1
    board = Board[['O','X','.','.','.']]
    assert @referee.row_score(0,board) == -1
    board = Board[['O','X','.','.','O']]
    assert @referee.row_score(0,board) == 0
    board = Board[['.','X','X','X','X']]
    assert_equal @referee.row_score(0,board),-1100
  end

  it "should give a score from a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    assert_equal @referee.score(board),-1105
  end

  it "should give a row score to a row of a board" do
    board = Board[['O'],['.'],['O'],['.'],['.']]
    assert_equal @referee.column_score(0,board),11
  end

  it "should give a diagonal_down score from a position of a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    assert_equal @referee.diagonal_down_score(0,1,board),-1
  end

  it "should give all diagonal_up scores from a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    assert_equal @referee.all_diagonal_up_score(board),-2
  end

  it "should give all diagonal_down scores from a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    assert_equal @referee.all_diagonal_down_score(board),-1
  end

  it "should give a diagonal_up score from a position of a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    assert_equal @referee.diagonal_up_score(0,3,board),-1
  end

  it "should give horizontal score to a board" do
    board = Board[['O','.','.','.','.'],
                  ['O','X','.','.','.'],
                  ['O','X','.','.','O'],
                  ['.','X','X','X','X']]
    assert_equal @referee.horizontal_score(board),-1100
  end

  it "should give vertical score to a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    assert_equal @referee.vertical_score(board),-1100
  end

  it "should give a score from a collection of placements" do
    assert @referee.heuristic('X','.','.','.') == -1
    assert @referee.heuristic('O','.','.','.') == 1
    assert @referee.heuristic('O','.','X','.') == 0
    assert_equal @referee.heuristic('.','.','.','.'),0
    assert @referee.heuristic('X','.','X','.') == -10
  end

end
