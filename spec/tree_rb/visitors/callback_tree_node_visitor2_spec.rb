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

  it CallbackTreeNodeVisitor2 do
    visitor = CallbackTreeNodeVisitor2.new
    visitor.on_enter_node{ |tree_node, new_parent_node|
      # puts "**** #{tree_node}"
      TreeNode.new("n" + tree_node.content, new_parent_node)
    }
    visitor.on_visit_leaf{ |leaf_node, new_parent_node|
      # puts "**** #{leaf_node}"
      LeafNode.new( "n" + leaf_node.content, new_parent_node )
    }
    @tree.accept( visitor )
    new_root = visitor.root
    expect(new_root.content).to be ==  "n" + @tree.content

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |node| accumulator << node.content}
    new_root.accept( visitor )
    expect(accumulator.length).to be == 5
    expect(accumulator).to be == %w{ na n1 n2 nb n3 }
  end

end
