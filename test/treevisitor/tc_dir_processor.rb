require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/dir_processor'

class TCDirProcessor < Test::Unit::TestCase

  TEST_DATA = File.join( TREEVISITOR_HOME, "test_data", "tree_visitor", "test_data" )

  def test_simple
    files = []
    dp = DirProcessor.new { |f| files << f }
    dp.process(TEST_DATA)
    assert_equal 3, files.length
  end
end
