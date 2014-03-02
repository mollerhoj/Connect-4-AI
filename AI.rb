class AI

  def next_move turn
    minimax
  end

  def minimax board
    max_value board,nil
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

  def utility board
    x = 0
    board.each_with_index do |e, row, col|
      if e == 'O'
        x += col+1
      end
    end
    x
  end

  def terminal? board
    if board.full?
      puts board
      true
    else
      false
    end
  end

  def min_value board,a
    if terminal?(board) then return [utility(board),a] end

    m = 999
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin action,"X"
      v = max_value(new_board,action)[0]
      if v < m then m = v;a = action end
    end
    [m,a]
  end

  def max_value board,a
    if terminal?(board) then return [a,utility(board),a] end

    m = -999
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin action,"O"
      v = min_value(new_board,action)[0]
      if v > m then m = v;a = action end
    end
    [m,a]
  end


end
