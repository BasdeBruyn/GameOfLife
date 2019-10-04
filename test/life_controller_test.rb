require_relative '../lib/life_controller'
require_relative '../lib/board'
require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

class LifeControllerTest < MiniTest::Unit::TestCase
  def setup
    @board = Board.new(10, 10)
    @life_controller = LifeController.new(@board)
  end
  
  def test_creationOfObjectOfClassLifeController_objectOfClassLifeController
    assert_instance_of(LifeController, @life_controller)
  end
  
  def test_getBoard_returnsObjectOfClassBoard
    @life_controller.create_board_from_seed([[]])
    
    assert_instance_of(Board, @board)
  end
  
  def test_createBoardFromArray_getBoardHasCorrectCellsAlive
    create_life_controller(3, 3)
    @board.initialize_cell_table
    seed = [[false,true,true],
            [false,false,false],
            [false,false,false]]
    
    @life_controller.create_board_from_seed(seed)
    
    assert(check_array_matches_board(seed, @board))
  end
  
  def test_startLifecycle_allCellsDie
    create_life_controller(3, 3)
    @board.initialize_cell_table
    seed = [[false,false,true],
            [false,false,false],
            [true,false,false]]
    @life_controller.create_board_from_seed(seed)
    
    @life_controller.start_lifecycle
  
    expected_board = [[false,false,false],
                      [false,false,false],
                      [false,false,false]]
    assert(check_array_matches_board(expected_board, @board))
  end

  def test_startLifecycle_seedBlinker_seedOcilates
    create_life_controller(3, 3)
    @board.initialize_cell_table
    seed = [[false,false,false],
            [true, true, true],
            [false,false,false]]
    @life_controller.create_board_from_seed(seed)
  
    @life_controller.start_lifecycle
  
    expected_board = [[false,true,false],
                      [false,true,false],
                      [false,true,false]]
    assert(check_array_matches_board(expected_board, @board))

    @life_controller.start_lifecycle

    assert(check_array_matches_board(seed, @board))
  end

  def test_startLifecycle_seedToad_seedOcilates
    create_life_controller(4, 4)
    @board.initialize_cell_table
    seed = [[false,false,false,false],
            [false,true, true, true],
            [true, true, true, false],
            [false,false,false,false]]
    @life_controller.create_board_from_seed(seed)
  
    @life_controller.start_lifecycle
  
    expected_board = [[false,false,true ,false],
                      [true ,false,false, true],
                      [true ,false,false, true],
                      [false,true ,false,false]]
    assert(check_array_matches_board(expected_board, @board))
  
    @life_controller.start_lifecycle
  
    assert(check_array_matches_board(seed, @board))
  end
  
  def check_array_matches_board(array, board)
    array.each_index do |x|
      array[x].each_index do |y|
        cell = board.get_cell_at(x,y)
        return false if array[y][x] != cell.is_alive
      end
    end
    true
  end
  
  def create_life_controller(x_length, y_length)
    @board = Board.new(x_length, y_length)
    @life_controller = LifeController.new(@board)
  end
end