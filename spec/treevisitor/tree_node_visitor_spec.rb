require File.join(File.dirname(__FILE__), "..", "spec_helper")

require 'treevisitor/visitors/block_tree_node_visitor'
require 'treevisitor/visitors/callback_tree_node_visitor'
require 'treevisitor/visitors/callback_tree_node_visitor2'
require 'treevisitor/visitors/clone_tree_node_visitor'
require 'treevisitor/visitors/depth_tree_node_visitor'

describe "TreeNodeVisitors" do

  before do
    ta = TreeNode.new( "a", nil )
    LeafNode.new("1", ta )
    LeafNode.new("2", ta )
    
    tb = TreeNode.new( "b", ta )
    LeafNode.new( "3", tb ) 
    
    @tree = ta
  end

  it "test_blocktreenodevisitor" do
    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.name}
    @tree.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ a 1 2 b 3 }
  end
  
  it "test_depthtreenodevisitor" do
    visitor = DepthTreeNodeVisitor.new
    @tree.accept( visitor )
    visitor.depth.should == 0

    visitor = CloneTreeNodeVisitor.new
    @tree.accept( visitor )
    visitor.cloned_root.nr_nodes.should ==  @tree.nr_nodes
  end
  
  it "test_callback_tree_node_visitor" do
    accumulator = []
    visitor = CallbackTreeNodeVisitor.new
    visitor.on_enter_tree_node{ |treeNode| accumulator << treeNode.name }
    visitor.on_visit_leaf_node{ |leafNode| accumulator << leafNode.name }
    @tree.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ a 1 2 b 3 }
  end
  
  it "test_callback_tree_node_visitor2" do
    visitor = CallbackTreeNodeVisitor2.new
    visitor.on_enter_tree_node{ |treeNode, newParentNode|
      TreeNode.new("n" + treeNode.name, newParentNode) 
    }
    visitor.on_visit_leaf_node{ |leafNode, newParentNode|
      LeafNode.new( "n" + leafNode.name, newParentNode )
    }
    @tree.accept( visitor )
    newRoot = visitor.root
    newRoot.name.should ==  "n" + @tree.name
    
    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.name}
    newRoot.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ na n1 n2 nb n3 }
  end

end
