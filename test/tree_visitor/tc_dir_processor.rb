require 'test/unit'

$TREE_VISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "lib" ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "test" ) )

$TEST_DATA = File.join( $TREE_VISITOR_HOME, "test", "tree_visitor", "test_data" )

require 'tree_visitor/dir_processor'

class TCDirProcessor < Test::Unit::TestCase
  def test_simple
    dp = DirProcessor.new($TEST_DATA) { |f| puts f }
    dp.run
  end
end
