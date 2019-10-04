require_relative '../lib/game_controller'
require 'minitest/autorun'
require 'stringio'
require 'o_stream_catcher'
require 'minitest/reporters'
MiniTest::Reporters.use!

class GameControllerTest < MiniTest::Unit::TestCase
  def setup
    @game_controller = GameController.new
  end

  def test_creationOfObjectOfClassLifeController_objectOfClassLifeController
    assert_instance_of(GameController, @game_controller)
  end
  
  def test_loadBoardFromUserInput_fromFile
    print_strings_to_console("y", "test/test_seeds/testSeed1.txt", "0.5")

    OStreamCatcher.catch do
      @game_controller.load_board_from_user_input
    end
    
    $stdin = STDIN
  end

  def test_loadBoardFromUserInput_fromNonExistingFile_raisesNoSuchFileEsception
    expected_value = 'No such file or directory @ rb_sysopen - nonExistingFile.txt'
  
    error = assert_raises(Errno::ENOENT) do
      print_strings_to_console("y", "nonExistingFile.txt", "0.5")

      OStreamCatcher.catch do
        @game_controller.load_board_from_user_input
      end
  
      $stdin = STDIN
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end
  
  def test_loadBoardFromUserInput_fromRandomSeed
    print_strings_to_console("n", "20", "20", "30", "0.5")

    OStreamCatcher.catch do
      @game_controller.load_board_from_user_input
    end

    $stdin = STDIN
  end

  def test_loadBoardFromUserInput_randomSeedWithNegativeWidth_raisesArgumentErrorWithCorrectMessage
    expected_value = 'Width must be greater than 0.'
  
    error = assert_raises(ArgumentError) do
      print_strings_to_console("n", "-8", "10", "100", "0.5")

      OStreamCatcher.catch do
        @game_controller.load_board_from_user_input
      end
    
      $stdin = STDIN
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_loadBoardFromUserInput_randomSeedWithNegativeHeight_raisesArgumentErrorWithCorrectMessage
    expected_value = 'Height must be greater than 0.'
  
    error = assert_raises(ArgumentError) do
      print_strings_to_console("n", "10", "-8", "100", "0.5")

      OStreamCatcher.catch do
        @game_controller.load_board_from_user_input
      end
    
      $stdin = STDIN
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_loadBoardFromUserInput_randomSeedWithNegativeLifeChance_raisesArgumentErrorWithCorrectMessage
    expected_value = 'Life chance must be between 1 and 100.'
  
    error = assert_raises(ArgumentError) do
      print_strings_to_console("n", "10", "10", "-100", "0.5")

      OStreamCatcher.catch do
        @game_controller.load_board_from_user_input
      end
    
      $stdin = STDIN
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_loadBoardFromUserInput_randomSeedWithLifeChance200_raisesArgumentErrorWithCorrectMessage
    expected_value = 'Life chance must be between 1 and 100.'
  
    error = assert_raises(ArgumentError) do
      print_strings_to_console("n", "10", "10", "200", "0.5")

      OStreamCatcher.catch do
        @game_controller.load_board_from_user_input
      end
    
      $stdin = STDIN
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_loadBoardFromUserInput_randomSeedWithNegativeLifecycleDuration_raisesArgumentErrorWithCorrectMessage
    expected_value = 'Time between lifecycles must be higher than 0.'
  
    error = assert_raises(ArgumentError) do
      print_strings_to_console("n", "10", "10", "100", "-0.5")
    
      OStreamCatcher.catch do
        @game_controller.load_board_from_user_input
      end
    
      $stdin = STDIN
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end
  
  def print_strings_to_console(*strings)
    string_io = StringIO.new
    strings.each do |string|
      string_io.puts(string)
    end
    string_io.rewind
    $stdin = string_io
  end
end