class LifeController
  
  def initialize(board)
    @board = board
  end

  def create_board_from_seed(seed)
    @y_length = @board.get_y_length
    @x_length = @board.get_x_length

    seed.each_index do |y|
      seed[y].each_index do |x|
        if seed[y][x]
          cell = @board.get_cell_at(x, y)
          cell.resurrect
          cell.determine_life_state
        end
      end
    end
  end

  def start_lifecycle
    (0..(@y_length - 1)).each do |y|
      (0..(@x_length - 1)).each do |x|
        determine_cell_life_state(x, y)
      end
    end

    (0..(@y_length - 1)).each do |y|
      (0..(@x_length - 1)).each do |x|
        @board.get_cell_at(x, y).determine_life_state
      end
    end
  end
  
  private
  
    def determine_cell_life_state(x, y)
      cell = @board.get_cell_at(x, y)
      neighbours_alive = count_neighbours_of_cell(x, y)
    
      if cell.is_alive && neighbours_alive < 2
        cell.die
      elsif cell.is_alive && (neighbours_alive == 2 || neighbours_alive == 3)
        #cell stays alive
      elsif cell.is_alive && neighbours_alive > 3
        cell.die
      elsif !cell.is_alive && neighbours_alive == 3
        cell.resurrect
      end
    end
  
    def count_neighbours_of_cell(x, y)
    x_offset = [-1,0,1,-1,1,-1,0,1]
    y_offset = [-1,-1,-1,0,0,1,1,1]
    neighbours_alive = 0
  
    x_offset.each_index do |index|
      x_pos = x + x_offset[index]
      y_pos = y + y_offset[index]
      unless (x_pos < 0 || x_pos >= @x_length) || (y_pos < 0 || y_pos >= @y_length)
        neighbour_cell = @board.get_cell_at(x_pos, y_pos)
        if neighbour_cell.is_alive
          neighbours_alive += 1
        end
      end
    end
    neighbours_alive
  end
end