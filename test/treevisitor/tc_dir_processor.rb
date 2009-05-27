require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/dir_processor'

class TCDirProcessor < Test::Unit::TestCase
  def test_simple
    dp = DirProcessor.new($TEST_DATA) { |f| puts f }
    dp.run
  end
end
