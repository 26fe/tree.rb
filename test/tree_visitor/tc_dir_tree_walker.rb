# stdlib
require 'test/unit'

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )
$TEST_DATA = File.join( $COMMON_HOME, "test", "tree_visitor", "test_data" )

require 'tree_visitor/dir_tree_walker.rb'
require 'tree_visitor/tree_node_visitor.rb'

class TCDirTreeWalker < Test::Unit::TestCase

  def test_simple  
    dir_tree_walker = DirTreeWalker.new( $TEST_DATA )
    dir_tree_walker.add_ignore_dir( ".svn" )

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename( pathname ) }
    dir_tree_walker.run( visitor )
    assert_equal( 7, accumulator.length )
    assert_equal( %w{ test_data dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 }, accumulator )
  end

end
