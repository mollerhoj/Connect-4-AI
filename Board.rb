require "Matrix"
require "pp"

BOARD_WIDTH = 3
BOARD_HEIGHT = 3

class Board < Matrix

  def self.construct
    Board.build(BOARD_HEIGHT,BOARD_WIDTH) {"."}
  end

  def coin_drop column,sign
    height.times do |x|
      row = height-1-x
      if self[row,column] == "."
        self[row,column] = sign
        break
      end
    end
  end

  def column_full? column
    height.times do |row|
      if self[row,column] == "."
        return false
      end
    end
    return true
  end

  def full?
    height.times do |column|
      if not column_full? column
        return false
      end
    end
    return true
  end
  
  def render
    str = ''
    self.each_with_index do |e, row, col|
      str+= "#{e}"
      if col == BOARD_WIDTH-1
        str+= "\n"
      end
    end
    str
  end

  alias_method :to_s, :render
  alias_method :width, :column_count
  alias_method :height, :row_count

end
