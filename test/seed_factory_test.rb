require_relative '../lib/seed_factory'
require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

class SeedFactoryTest < MiniTest::Unit::TestCase
  
  def test_createSeedFromFile_returnsCorrectSeed
    expected_value = [[false,true,false],
                      [false,true,false],
                      [false,true,false]]
    
    actual_value = SeedFactory.create_seed_from_file('test/test_seeds/testSeed1.txt')
    
    assert_equal(expected_value, actual_value)
  end

  def test_createSeedFromFile_unevenRows_raisesStandardErrorWithCorrectMessage
    expected_value = 'rows should be of the same size'
    
    error = assert_raises(StandardError) do
      SeedFactory.create_seed_from_file('test/test_seeds/testSeed2.txt')
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_createSeedFromFile_emptyFile_raisesStandardErrorWithCorrectMessage
    expected_value = 'empty file'
  
    error = assert_raises(StandardError) do
      SeedFactory.create_seed_from_file('test/test_seeds/testSeed3.txt')
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_createSeedFromFile_nonExistingFile_raisesFileNotFoundException
    expected_value = 'No such file or directory @ rb_sysopen - nonExistingFile.txt'
  
    error = assert_raises(Errno::ENOENT) do
      SeedFactory.create_seed_from_file('nonExistingFile.txt')
    end
    actual_value = error.message
  
    assert_equal(expected_value, actual_value)
  end

  def test_createRandomSeed_returnsObjectOfTypeArray
    object = SeedFactory.create_random_seed(15, 15, 100)
    
    assert_instance_of(Array, object)
  end
  
end