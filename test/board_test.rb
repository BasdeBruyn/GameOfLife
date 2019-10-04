require_relative '../lib/board'
require_relative '../lib/life_controller'
require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

class BoardTest < MiniTest::Unit::TestCase
  def setup
    create_board(0,0)
  end
  
  def test_creationOfObjectOfClassBoard_objectOfClassBoard
    assert_instance_of(Board, @board)
  end
  
  def test_getXLength_boardOfSizeTenTen_returnsTen
    create_board(10, 10)
    expected_value = 10
    
    actual_value = @board.get_x_length
    
    assert_equal(expected_value, actual_value)
  end

  def test_getYLength_boardOfSizeTenTen_returnsTen
    create_board(10, 10)
    expected_value = 10
  
    actual_value = @board.get_y_length
  
    assert_equal(expected_value, actual_value)
  end
  
  def test_getCellAt_ParamatersOneOne_throwsIndexOutOfBounds
    assert_raises(IndexError) do
      cell = @board.get_cell_at(1, 1)
    end
  end
  
  def test_creationOfObjectOfClassBoard_ParamatersZeroZero_objectOfClassBoard
    create_board(0,0)
    
    assert_instance_of(Board, @board)
  end
  
  def test_creationOfObjectOfClassBoardOfSizeTenTen_getCellAtNineNineReturnsNil
    create_board(10,10)
    
    cell = @board.get_cell_at(9, 9)
    
    assert_nil(cell)
  end
  
  def test_initialzieCellTable_boardOfSizeTenTen_getCellAtNineNinereturnsObjectOfClassCell
    create_board(10, 10)
    
    @board.initialize_cell_table
    
    cell = @board.get_cell_at(9, 9)
    assert_instance_of(Cell, cell)
  end
  
  def test_toS_returnsString
    string = @board.to_s
    
    assert_instance_of(String, string)
  end

  def test_toS_returnsCorrectString
    create_board(4, 4)
    @board.initialize_cell_table
    life_controller = LifeController.new(@board)
    seed = [[false,false,true ,false],
            [true ,false,false, true],
            [true ,false,false, true],
            [false,true ,false,false]]
    life_controller.create_board_from_seed(seed)
    expected_value = ". . # .\n# . . #\n# . . #\n. # . .\n"
    actual_value = @board.to_s
    assert_equal(expected_value, actual_value)
  end
  
  def create_board(x_length, y_length)
    @board = Board.new(x_length, y_length)
  end
  
end