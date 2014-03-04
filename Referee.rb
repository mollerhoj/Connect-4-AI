class Referee

  def initialize func=:col
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

  def winner? board

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

  def col a,b,c,d
    x = 0
    o = 0
    [a,b,c,d].each do |e|
      if e == 'X' then x+=1 end
      if e == 'O' then o+=1 end
    end
    if x>0 and o>0 then return 0 end
    if x>0 then return -(10**x) else return 10**o end
  end

  def val a,b,c,d
    self.send(@func,a,b,c,d)
  end

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
