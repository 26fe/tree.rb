require 'test/unit'

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )

require 'common/treenode.rb'

class TestTreeNode < Test::Unit::TestCase

  def test_simple

    ta = TreeNode.new( nil, "a" )
    assert( ta.root? )

    ln1 = LeafNode.new(ta, "1")
    assert_equal( ta, ln1.parent )
    ta.add_leaf( ln1 )

    ln2 = LeafNode.new(ta, "2")
    ta.add_leaf( ln2 )

    #
    tb = TreeNode.new( ta, "b" )
    ln3 = LeafNode.new( tb, "3" )
    tb.add_leaf( ln3 )
    assert_equal( tb, ln3.parent )

    ta.add_child( tb )
    puts ta.to_s

  end


end
