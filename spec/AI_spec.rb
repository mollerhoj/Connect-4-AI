require "./spec/.spec_helper"

describe AI do

  before do
    board = Board.construct
    @ai = AI.new board
  end

  it "should run minimax algoritm" do
    puts "AI!"
  end

end
