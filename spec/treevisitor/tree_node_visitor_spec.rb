# -*- coding: utf-8 -*-
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

  it BlockTreeNodeVisitor do
    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.content}
    @tree.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ a 1 2 b 3 }
  end
  
  it DepthTreeNodeVisitor do
    visitor = DepthTreeNodeVisitor.new
    @tree.accept( visitor )
    visitor.depth.should == 0

    visitor = CloneTreeNodeVisitor.new
    @tree.accept( visitor )
    visitor.cloned_root.nr_nodes.should ==  @tree.nr_nodes
  end
  
  it CallbackTreeNodeVisitor do
    accumulator = []
    visitor = CallbackTreeNodeVisitor.new
    visitor.on_enter_tree_node{ |tree_node| accumulator << tree_node.content }
    visitor.on_visit_leaf_node{ |leaf_node| accumulator << leaf_node.content }
    @tree.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ a 1 2 b 3 }
  end
  
  it CallbackTreeNodeVisitor2 do
    visitor = CallbackTreeNodeVisitor2.new
    visitor.on_enter_tree_node{ |tree_node, new_parent_node|
      TreeNode.new("n" + tree_node.content, new_parent_node)
    }
    visitor.on_visit_leaf_node{ |leaf_node, new_parent_node|
      LeafNode.new( "n" + leaf_node.content, new_parent_node )
    }
    @tree.accept( visitor )
    new_root = visitor.root
    new_root.content.should ==  "n" + @tree.content
    
    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.content}
    new_root.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ na n1 n2 nb n3 }
  end

end
