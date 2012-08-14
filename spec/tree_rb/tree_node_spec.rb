# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe TreeNode do

  it "should initialize correctly" do
    ta = TreeNode.new("a")
    ta.should be_root

    ln1 = LeafNode.new("1", ta)
    ln1.parent.should == ta
    ln1.should_not be_root

    ln2 = LeafNode.new("2", ta)
    tb  = TreeNode.new("b", ta)
    ln3 = LeafNode.new("3", tb)
    ln3.parent.should == tb

    # test depth
    tb.depth.should == 2
    ln3.depth.should == 3

    # test nr_nodes
    tb.nr_nodes.should == 1
    ta.nr_nodes.should == 4

    # puts ta.to_str
  end

  it "should add child and leaf" do
    ta = TreeNode.new("a")
    ta.should be_root

    ln1 = LeafNode.new("1")
    ta.add_leaf(ln1)
    ln1.parent.should == ta

    ln2 = LeafNode.new("2", ta)
    ta.add_leaf(ln2)

    tb  = TreeNode.new("b", ta)
    ln3 = LeafNode.new("3", tb)
    tb.add_leaf(ln3)
    ln3.parent.should == tb

    ta.add_child(tb)
    # puts ta.to_str
  end

  it "next and prev" do
    ta = TreeNode.new("a")
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

  context "navigate tree" do

    before do
      @tree     = TreeNode.new("a")
      ln1       = LeafNode.new("1", @tree)
      ln2       = LeafNode.new("2", @tree)
      @sub_tree = TreeNode.new("b", @tree)
      @ln3      = LeafNode.new("3", @sub_tree)
      @ln4      = LeafNode.new("12", @sub_tree)
    end

    it "nr_nodes and nr_leaves and nr_children" do
      @tree.nr_nodes.should == 5
      @tree.nr_leaves.should == 4
      @tree.nr_children.should == 1

      @sub_tree.nr_nodes.should == 2
      @sub_tree.nr_leaves.should == 2
      @sub_tree.nr_children.should == 0
    end


    context "find" do

      it "find by string" do
        @tree.find("a").should === @tree
        @tree.find("b").should === @sub_tree
        @tree.find("3").should === @ln3
        @tree.find("not existent").should be_nil
      end

      it "find by regex" do
        @tree.find(/[a,b]/).should === @tree
        @tree.find(/[b,c]/).should === @sub_tree
        @tree.find(/\d\d/).should === @ln4
        @tree.find(/not existent/).should be_nil
      end

      it "find with block" do
        @tree.find { |e| e.content == "a" }.should === @tree
        @tree.find { |e| e.content == "b" }.should === @sub_tree
        @tree.find { |e| e.content == "3" }.should === @ln3
        @tree.find { |e| e.content == "not existent" }.should be_nil
      end

      it "to_str" do
        out = <<EOS
a
|-- 1
|-- 2
`-- b
    |-- 3
    `-- 12
EOS
        @tree.to_str.should == out
      end

    end

  end
end
