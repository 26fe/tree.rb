require 'test/unit'

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )

require 'common/tree_node.rb'
require 'common/tree_node_visitor.rb'

class TestTreeNodeVisitor < Test::Unit::TestCase

  def setup
    ta = TreeNode.new( "a", nil )
    LeafNode.new("1", ta )
    LeafNode.new("2", ta )
    
    tb = TreeNode.new( "b", ta )
    LeafNode.new( "3", tb ) 
    
    @tree = ta
  end

  def test_blocktreenodevisitor

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.name}
    @tree.accept( visitor )
    assert_equal( 5, accumulator.length )
    assert_equal( %w{ a 1 2 b 3 }, accumulator )
  end
  
  def test_depthtreenodevisitor
    visitor = DepthTreeNodeVisitor.new
    @tree.accept( visitor )
    assert_equal( 0, visitor.depth )
    
    visitor = CloneTreeNodeVisitor.new
    @tree.accept( visitor )
    assert_equal(@tree.nr_nodes, visitor.clonedRoot.nr_nodes )
  end


end
