# stdlib
require 'test/unit'

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )

require 'common/treenode.rb'

class TestTreeNode < Test::Unit::TestCase

  def test_simple_build
    ta = TreeNode.new( "a" )
    assert( ta.root? )
    ln1 = LeafNode.new("1", ta)
    assert_equal( ta, ln1.parent )
    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )
    assert_equal( tb, ln3.parent )
    
    # test depth
    assert_equal( 2, tb.depth )
    assert_equal( 3, ln3.depth )
    
    # test nr_nodes
    assert_equal( 1, tb.nr_nodes )
    assert_equal( 4, ta.nr_nodes )

    # puts ta.to_str
  end

  def test_add_methods
    ta = TreeNode.new( "a" )
    assert( ta.root? )
    
    ln1 = LeafNode.new("1")
    ta.add_leaf( ln1 )
    assert_equal( ta, ln1.parent )

    ln2 = LeafNode.new("2", ta)
    ta.add_leaf( ln2 )

    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )
    tb.add_leaf( ln3 )
    assert_equal( tb, ln3.parent )

    ta.add_child( tb )
    # puts ta.to_str
  end

end
