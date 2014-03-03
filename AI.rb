class AI

  def actions board
    actions = []
    board.width.times do |x|
      if !board.column_full? x
        actions << x
      end
    end
    actions
  end

  def utility board
    x = 0
    board.each_with_index do |e, row, col|
      if e == 'O'
        x += col+1
      end
      if e == 'X'
        x -= col+1
      end
    end
    #puts x
    x
  end

  def terminal? board
    if board.full?
      #puts "T"
      true
    else
      false
    end
  end

  def next_move board
    minimax(board)[1]
  end

  def minimax board
    max_value board,nil,-999,999
  end

  def min_value board,pre_action,a,b
    #puts "mix"
    #puts board
    if terminal?(board) then return [utility(board),pre_action] end

    m = 999
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin action,"X"
      v = max_value(new_board,action,a,b)[0]
      if v < m then m = v;pre_action = action end
      #if v <= a then return [v,pre_action] end
      if m < b then b = m end
    end
    [m,pre_action]
  end

  def max_value board,pre_action,a,b
    #puts "max"
    #puts board
    if terminal?(board) then return [utility(board),pre_action] end

    m = -999
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin action,"O"
      v = min_value(new_board,action,a,b)[0]
      if v > m then m = v;pre_action = action end
      #if v >= b then return [v,pre_action] end
      if m > a then a = m end
    end
    [m,pre_action]
  end


end
