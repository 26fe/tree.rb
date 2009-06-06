require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/tree_node.rb'
require 'treevisitor/tree_node_visitor.rb'
require 'treevisitor/visitors/block_tree_node_visitor'
require 'treevisitor/visitors/callback_tree_node_visitor'
require 'treevisitor/visitors/callback_tree_node_visitor2'
require 'treevisitor/visitors/clone_tree_node_visitor'
require 'treevisitor/visitors/depth_tree_node_visitor'

class TCTreeNodeVisitor < Test::Unit::TestCase

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
    assert_equal(@tree.nr_nodes, visitor.cloned_root.nr_nodes )
  end
  
  def test_callback_tree_node_visitor
    accumulator = []
    visitor = CallbackTreeNodeVisitor.new
    visitor.on_enter_tree_node{ |treeNode| accumulator << treeNode.name }
    visitor.on_visit_leaf_node{ |leafNode| accumulator << leafNode.name }
    @tree.accept( visitor )
    assert_equal( 5, accumulator.length )
    assert_equal( %w{ a 1 2 b 3 }, accumulator )
  end
  
  def test_callback_tree_node_visitor2
    visitor = CallbackTreeNodeVisitor2.new
    visitor.on_enter_tree_node{ |treeNode, newParentNode|
      TreeNode.new("n" + treeNode.name, newParentNode) 
    }
    visitor.on_visit_leaf_node{ |leafNode, newParentNode|
      LeafNode.new( "n" + leafNode.name, newParentNode )
    }
    @tree.accept( visitor )
    newRoot = visitor.root
    assert_equal( "n" + @tree.name, newRoot.name)
    
    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.name}
    newRoot.accept( visitor )
    assert_equal( 5, accumulator.length )
    assert_equal( %w{ na n1 n2 nb n3 }, accumulator )
  end

end
