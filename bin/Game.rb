require "./Board.rb"
require "./AI.rb"
require "./Referee.rb"

#A little script that starts a standard Human vs. CPU game.

@board = Board.construct(7,6)
ai = AI.new()
@referee = Referee.new(:winner)

def input_valid? move
  if move < 0 then return false end
  if move > 6 then return false end
  if @board.column_full? move then return false end
  true
end

# Clear some space
10.times {puts "\n"}

# Game loop
["cpu","human"].cycle do |player|

  if player == "human"
    move = (gets.chomp).to_i
    while !input_valid?(move)
      move = (gets.chomp).to_i
    end

    @board.drop_coin(move,"X")
  else
    move = ai.next_move @board
    if move == nil
      puts "ERROR"
    end
    @board.drop_coin(move,"O")

    puts "\e[#{@board.height+3}A"

    puts @board
  end

  winner = @referee.score(@board)
  full = @board.full?

  if full || winner != 0
    puts "_____________________"
    puts @board
    if winner == 0 then puts "DRAW!" end
    if winner == 1 then puts "YOU LOSE!" end
    if winner == -1 then puts "YOU WIN!" end
    break
  end
end
