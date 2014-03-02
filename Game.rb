require "./Board.rb"
require "./AI.rb"
require "./Referee.rb"

@board = Board.construct
referee = Referee.new(@board)
ai = AI.new(@board)

def input_valid? move
  if move < 0 then return false end
  if move > 6 then return false end
  if @board.column_full? move then return false end
  true
end

def run
  ["cpu","human"].cycle do |player|

    if player == "human"
      move = (gets.chomp).to_i
      while !input_valid?(move)
        puts "input invalid"
        move = (gets.chomp).to_i
      end

      @board.coin_drop(move,"X")
    else
      move = ai.next_move 1
      @board.coin_drop(move,"O")
      puts @board
    end

    winner = referee.winner?
    full = @board.full?

    if winner != 0 || full
      puts winner
      break
    end
  end
end

