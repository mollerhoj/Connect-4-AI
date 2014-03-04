class AI

  def initialize
    @referee = Referee.new
    @win_referee = Referee.new(:winner)
  end

  def actions board
    actions = []
    board.width.times do |x|
      if !board.column_full? x
        actions << x
      end
    end
    actions
  end

  def evaluate board
    @referee.score(board)
  end

  def evaluate_depricated board
    x = 0
    board.each_with_index do |e, row, col|
      if e == 'O'
        x += col+1
      end
      if e == 'X'
        x -= col+1
      end
    end
    x
  end

  def cut_off? board,depth
    if depth >= 3 || board.full? || @win_referee.score(board) != 0
      true
    else
      false
    end
  end

  def next_move board
    minimax(board)[1]
  end

  def minimax board
    s = max_value board,nil,-999,999,0
    puts "move #{s[1]} yields #{s[0]} points."
    s
  end

  def min_value board,pre_action,a,b,depth
    if cut_off?(board,depth) then return [evaluate(board),pre_action] end

    m = 9999999
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin action,"X"
      v = max_value(new_board,action,a,b,depth+1)[0]
      if v < m then m = v;pre_action = action end
      #if v <= a then return [v,pre_action] end
      if m < b then b = m end
    end
    [m,pre_action]
  end

  def max_value board,pre_action,a,b,depth
    if cut_off?(board,depth) then return [evaluate(board),pre_action] end

    m = -9999999
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin action,"O"
      v = min_value(new_board,action,a,b,depth+1)[0]
      if v > m then m = v;pre_action = action end
      #if v >= b then return [v,pre_action] end
      if m > a then a = m end
    end
    [m,pre_action]
  end

end
