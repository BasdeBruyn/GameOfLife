require_relative 'cell'

class Board
  def initialize(x_length, y_length)
    @x_length = x_length
    @y_length = y_length
    @cell_table = Array.new(@y_length){ Array.new(@x_length) }
  end

  def get_x_length
    @x_length
  end

  def get_y_length
    @y_length
  end
  
  def get_cell_at(x_pos, y_pos)
    raise IndexError if x_pos < 0 || x_pos >= @x_length
    raise IndexError if y_pos < 0 || y_pos >= @y_length
    @cell_table[y_pos][x_pos]
  end

  def initialize_cell_table
    @cell_table.each_index do |index_y|
      @cell_table[index_y].each_index do |index_x|
        @cell_table[index_y][index_x] = Cell.new
      end
    end
  end
  
  def to_s
    string = ''
    
    @cell_table.each do |y_axis|
      string += cell_row_to_s(y_axis)
    end
    string
  end

  private
  
    def cell_row_to_s(row)
      string = ""
      row.each do |cell|
        string += cell.to_s
        string += " "
      end
      string = string.chop
      string += "\n"
    end
end