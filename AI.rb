class AI

  def initialize board
    @board = board
  end

  def next_move turn
    minimax
  end

  private

  def minimax board
    max_value @board
  end

  def actions board
    actions = []
    board.width.times do |x|
      if !board.full?
        actions << x
      end
    end
    actions
  end

  def utility board

  end

  def terminal_test? board
    board.full?
  end

  def min_value board
    if terminal_test?(board) then return utility(board) end

    m = 999
    actions.each do |action|
      new_board = @board.clone
      new_board.coin_drop action,"X"
      v = max_value new_board
      if v < m then m = v end
    end
    m
  end

  def max_value board
    if terminal_test?(board) then return utility(board) end

    m = -999
    actions.each do |action|
      new_board = @board.clone
      new_board.coin_drop action,"O"
      v = max_value new_board
      if v > m then m = v end
    end
    m
  end

end
