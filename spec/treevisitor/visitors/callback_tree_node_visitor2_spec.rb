# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

require 'treevisitor/visitors/callback_tree_node_visitor2'

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
