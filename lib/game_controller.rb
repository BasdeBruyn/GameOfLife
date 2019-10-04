require_relative 'seed_factory'
require_relative 'board'
require_relative 'life_controller'

class GameController
  
  def load_board_from_user_input
    print("Load board from file? (y/n) :")
    load_choice = gets.chomp.downcase
    
    case load_choice
      when "y"
        get_file_location_from_user_input
        load_board_from_file
      when "n"
        get_board_configuration_from_user_input
        load_random_board
      else
        raise ArgumentError.new(load_choice + " is no option")
    end
  end
  
  def start_game(lifecycle_duration)
    @life_controller.start_lifecycle
    
    print_board
    
    begin
      sleep(lifecycle_duration)
    rescue SystemExit, Interrupt
      return
    end
      
    start_game(lifecycle_duration)
  end

  private
  
    def get_file_location_from_user_input
      print("File location:")
      @file_location = gets.chomp
    end
  
    def get_board_configuration_from_user_input
      puts("Board will be created from random seed.")
      print("Board width:")
      @x_length = gets.chomp.to_i
    
      print("Board height:")
      @y_length = gets.chomp.to_i
    
      print("Chance for cell to be alive (1-100) :")
      @life_chance = gets.chomp.to_i
    end
  
    def load_random_board
      @seed = SeedFactory.create_random_seed(@x_length, @y_length, @life_chance)
    
      create_board
      create_life_controller
    end
  
    def load_board_from_file
      @seed = SeedFactory.create_seed_from_file(@file_location)
      @y_length = @seed.length
      @x_length = @seed[0].length
    
      create_board
      create_life_controller
    end
    
    def print_board
      puts("\n" * 15)
      puts(@board.to_s)
    end
  
    def create_board
      @board = Board.new(@x_length, @y_length)
      @board.initialize_cell_table
    end
  
    def create_life_controller
      @life_controller = LifeController.new(@board)
      @life_controller.create_board_from_seed(@seed)
    end
end