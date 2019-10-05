class LifeController
  
  def initialize(board)
    @board = board
  end

  def create_board_from_seed(seed)
    @y_length = @board.get_y_length
    @x_length = @board.get_x_length

    seed.each_index do |y_index|
      seed[y_index].each_index do |x_index|
        if seed[y_index][x_index]
          resurrect_cell(x_index, y_index)
        end
      end
    end
  end

  def start_lifecycle
    (0..(@y_length - 1)).each do |y_index|
      (0..(@x_length - 1)).each do |x_index|
        determine_cell_life_state(x_index, y_index)
      end
    end

    (0..(@y_length - 1)).each do |y_index|
      (0..(@x_length - 1)).each do |x_index|
        @board.get_cell_at(x_index, y_index).finalize_life_state
      end
    end
  end
  
  private
    
    def resurrect_cell(x_index, y_index)
      cell = @board.get_cell_at(x_index, y_index)
      cell.resurrect
      cell.finalize_life_state
    end
  
    def determine_cell_life_state(x_index, y_index)
      cell = @board.get_cell_at(x_index, y_index)
      neighbours_alive = count_neighbours_of_cell(x_index, y_index)
    
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
    
      x_offset.each_index do |offset_index|
        neighbour_x_index = x + x_offset[offset_index]
        neighbour_y_index = y + y_offset[offset_index]
        
        next if (neighbour_x_index < 0 || neighbour_x_index >= @x_length)
        next if (neighbour_y_index < 0 || neighbour_y_index >= @y_length)
        
        neighbour_cell = @board.get_cell_at(neighbour_x_index, neighbour_y_index)
        if neighbour_cell.is_alive
          neighbours_alive += 1
        end
      end
      
      neighbours_alive
    end
end