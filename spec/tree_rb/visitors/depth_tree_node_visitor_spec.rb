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

  it DepthTreeNodeVisitor do
    visitor = DepthTreeNodeVisitor.new
    @tree.accept( visitor )
    expect(visitor.depth).to be == 0

    visitor = CloneTreeNodeVisitor.new
    @tree.accept( visitor )
    expect(visitor.cloned_root.nr_nodes).to be ==  @tree.nr_nodes
  end
  
end
