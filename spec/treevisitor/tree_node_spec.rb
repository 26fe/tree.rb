# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

# require 'treevisitor/tree_node.rb'

describe TreeNode do

  it "new" do
    ta = TreeNode.new( "a" )
    ta.should be_root

    ln1 = LeafNode.new("1", ta)
    ln1.parent.should == ta
    ln1.should_not be_root

    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )
    ln3.parent.should == tb

    # test depth
    tb.depth.should == 2
    ln3.depth.should == 3

    # test nr_nodes
    tb.nr_nodes.should == 1
    ta.nr_nodes.should == 4

    # puts ta.to_str
  end

  it "add_child_and_add_leaf" do
    ta = TreeNode.new( "a" )
    ta.should be_root

    ln1 = LeafNode.new("1")
    ta.add_leaf( ln1 )
    ln1.parent.should == ta

    ln2 = LeafNode.new("2", ta)
    ta.add_leaf( ln2 )

    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )
    tb.add_leaf( ln3 )
    ln3.parent.should == tb

    ta.add_child( tb )
    # puts ta.to_str
  end

  it "next_and_prev" do
    ta = TreeNode.new( "a" )
    ta.prev.should be_nil
    ta.next.should be_nil

    ln1 = LeafNode.new("1", ta)
    ln1.prev.should be_nil
    ln1.next.should be_nil

    ln2 = LeafNode.new("2", ta)
    ln2.prev.should == ln1
    ln2.next.should be_nil

    ln3 = LeafNode.new("3", ta)
    ln2.next.should == ln3

    tb = TreeNode.new("b", ta)
    tb.next.should be_nil
    tb.prev.should be_nil

    tc = TreeNode.new("c", ta)
    tc.prev.should == tb
    tc.next.should be_nil
  end

  it "nr_nodes_and_nr_leaves_adn_nr_children" do
    ta = TreeNode.new( "a" )
    ln1 = LeafNode.new("1", ta)
    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )

    ta.nr_nodes.should == 4
    ta.nr_leaves.should ==  3
    ta.nr_children.should == 1

    tb.nr_nodes.should == 1
    tb.nr_leaves.should == 1
    tb.nr_children.should == 0
  end

  it "prefix_path" do
    ta = TreeNode.new( "a" )
    ln1 = LeafNode.new("1", ta)
    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )

    ta.path.should == "a"
    tb.path.should == "a/b"
    ta.path_with_prefix.should ==  "a"
    tb.path_with_prefix.should == "a/b"

    ta.prefix_path= "<root>/"

    ta.prefix_path.should == "<root>/"
    ta.path.should == "a"
    tb.path.should == "a/b"
    ta.path_with_prefix.should == "<root>/a"
    tb.path_with_prefix.should == "<root>/a/b"
  end

  it "invalidate" do
    ta = TreeNode.new( "a" )
    ln1 = LeafNode.new("1", ta)
    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )

    ta.prefix_path="root/"
    tb.path.should == "a/b"
    tb.path_with_prefix.should == "root/a/b"
    tb.depth.should == 2

    r = TreeNode.new( "r" )
    r.add_child( ta )
    tb.path.should == "r/a/b"
    tb.path_with_prefix.should == "r/a/b"

    r.prefix_path="new_root/"
    tb.path.should == "r/a/b"
    tb.path_with_prefix.should == "new_root/r/a/b"
    tb.depth.should == 3
  end

  it "find" do
    ta = TreeNode.new( "a" )
    ln1 = LeafNode.new("1", ta)
    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )

    ta.find( "3").should == ln3
    ta.find( "b").should == tb
    ta.find("not existent").should be_nil
  end

  it "to_str" do
    ta = TreeNode.new( "a" )
    ln1 = LeafNode.new("1", ta)
    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )

    out = <<EOS
a
|-- 1
|-- 2
`-- b
    `-- 3
EOS
    out.should == ta.to_str
  end


end

