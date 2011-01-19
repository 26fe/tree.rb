# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

require 'treevisitor/visitors/depth_tree_node_visitor'
require 'treevisitor/visitors/clone_tree_node_visitor'

describe "Tree Node Visitors" do

  before do
    ta = TreeNode.new( "a", nil )
    LeafNode.new("1", ta )
    LeafNode.new("2", ta )
    
    tb = TreeNode.new( "b", ta )
    LeafNode.new( "3", tb ) 
    
    @tree = ta
  end

  it DepthTreeNodeVisitor do
    visitor = DepthTreeNodeVisitor.new
    @tree.accept( visitor )
    visitor.depth.should == 0

    visitor = CloneTreeNodeVisitor.new
    @tree.accept( visitor )
    visitor.cloned_root.nr_nodes.should ==  @tree.nr_nodes
  end
  
end
