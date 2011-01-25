# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe "Tree Node Visitors" do

  before do
    ta = TreeNode.new( "a", nil )
    LeafNode.new("1", ta )
    LeafNode.new("2", ta )
    
    tb = TreeNode.new( "b", ta )
    LeafNode.new( "3", tb ) 
    
    @tree = ta
  end

  it CallbackTreeNodeVisitor do
    accumulator = []
    visitor = CallbackTreeNodeVisitor.new
    visitor.on_enter_node{ |tree_node| accumulator << tree_node.content }
    visitor.on_visit_leaf{ |leaf_node| accumulator << leaf_node.content }
    @tree.accept( visitor )
    accumulator.length.should == 5
    accumulator.should == %w{ a 1 2 b 3 }
  end
  
end
