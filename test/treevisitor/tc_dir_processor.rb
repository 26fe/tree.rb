require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/dir_processor'

class TCDirProcessor < Test::Unit::TestCase

  TEST_DATA = File.join( $TREEVISITOR_HOME, "test_data", "tree_visitor", "test_data" )

  def test_simple
    files = []
    dp = DirProcessor.new(TEST_DATA) { |f| files << f }
    dp.run
    assert_equal 3, files.length
  end
end
