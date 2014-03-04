class Referee

  # if the referee is initialized with :winner, then it only jugdes who has won.
  def initialize func=:heuristic
    @func = func
  end

  def score board 
    s = 0
    s+=horizontal_score board
    s+=vertical_score board
    s+=all_diagonal_up_score board
    s+=all_diagonal_down_score board
    s
  end

  def horizontal_score board
    s = 0
    board.height.times do |y|
      s+= row_score(y,board)
    end
    s
  end

  def vertical_score board
    s = 0
    board.width.times do |x|
      s+= column_score(x,board)
    end
    s
  end

  def row_score y,board
    s = 0
    (board.width-3).times do |x|
      s+=val(board[x,y],board[x+1,y],board[x+2,y],board[x+3,y])
    end
    s
  end

  def column_score x,board
    s = 0
    (board.height-3).times do |y|
      s+=val(board[x,y],board[x,y+1],board[x,y+2],board[x,y+3])
    end
    s
  end

  def all_diagonal_down_score board
    s = 0
    (board.width-3).times do |x|
      (board.height-3).times do |y|
        s+=diagonal_down_score x,y,board
      end
    end
    s
  end

  def all_diagonal_up_score board
    s = 0
    (board.width-3).times do |x|
      (board.height-3).times do |y|
        s+=diagonal_up_score(x,y+3,board)
      end
    end
    s
  end

  def diagonal_down_score x,y,board
    val(board[x,y],board[x+1,y+1],board[x+2,y+2],board[x+3,y+3])
  end

  def diagonal_up_score x,y,board
    val(board[x,y],board[x+1,y-1],board[x+2,y-2],board[x+3,y-3])
  end

  # Choose function from initial set
  def val a,b,c,d
    self.send(@func,a,b,c,d)
  end

  # The heuristic gives points to a space of four cells in which it might be
  # possible to get a 4x4. if both X's and O's are present, it is not possible
  # to get a 4x4, and the function yields 0. Otherwise, the function returns: 
  #
  # For 1 O:   1
  # For 2 O's: 10
  # For 3 O's: 100
  # For 4 O's: 1000
  # For 1 X:   -1
  # For 2 X's: -10
  # For 3 X's: -100
  # For 4 X's: -1000

  def heuristic a,b,c,d
    x = 0
    o = 0
    [a,b,c,d].each do |e|
      if e == 'X' then x+=1 end
      if e == 'O' then o+=1 end
    end
    if x>0 and o>0 then return 0 end
    if x>0 then return -(10**(x-1)) end
    if o>0 then return 10**(o-1) end
    return 0
  end

  # return 1 if CPU won, -1 if player won, and 0 otherwise
  def winner a,b,c,d
    x = 0
    o = 0
    [a,b,c,d].each do |e|
      if e == 'X' then x+=1 end
      if e == 'O' then o+=1 end
    end
    if x>0 and o>0 then return 0 end
    if x==4 then return -1 end
    if o==4 then return 1 end
    return 0
  end

end
