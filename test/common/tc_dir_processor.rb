require 'test/unit'
require 'config'
require 'dir_processor'

class TestDirProcessor < Test::Unit::TestCase
  def test_simple
    dp = DirProcessor.new($TEST_GALLERIES) { |f| puts f }
    dp.run
  end
end