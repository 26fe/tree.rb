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

  it BlockTreeNodeVisitor do
    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.content}
    @tree.accept( visitor )
    expect(accumulator.length).to be == 5
    expect(accumulator).to be == %w{ a 1 2 b 3 }
  end

end
