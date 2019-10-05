require_relative '../lib/cell'
require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

class CellTest < MiniTest::Unit::TestCase
  def setup
    @default_cell = Cell.new
  end
  
  def test_creationOfObjectOfClassCell_objectOfClassCell
    assert_instance_of(Cell, @default_cell)
  end

  def test_isALive_returnsFalse
    expected_value = false
    actual_value = @default_cell.is_alive
    
    assert_equal(expected_value, actual_value)
  end
  
  def test_willBeAlive_returnsFalse
    expected_value = false
    actual_value = @default_cell.will_be_alive
  
    assert_equal(expected_value, actual_value)
  end
  
  def test_resurrect_willBeAliveReturnsTrue
    @default_cell.resurrect

    expected_value = true
    actual_value = @default_cell.will_be_alive
    
    assert_equal(expected_value, actual_value)
  end

  def test_die_willBeAliveReturnsFalse
    @default_cell.die
  
    expected_value = false
    actual_value = @default_cell.will_be_alive
  
    assert_equal(expected_value, actual_value)
  end
  
  def test_determineLifeState_isAliveReturnsFalse
    @default_cell.finalize_life_state
  
    expected_value = false
    actual_value = @default_cell.is_alive
  
    assert_equal(expected_value, actual_value)
  end

  def test_determineLifeState_resurrectCalledOnCell_isAliveReturnsTrue
    @default_cell.resurrect
    
    @default_cell.finalize_life_state
  
    expected_value = true
    actual_value = @default_cell.is_alive
  
    assert_equal(expected_value, actual_value)
  end
end