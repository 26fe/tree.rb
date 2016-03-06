# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe TreeNode do

  it "should initialize correctly" do
    ta = TreeNode.new("a")
    expect(ta).to be_root

    ln1 = LeafNode.new("1", ta)
    expect(ln1.parent).to be == ta
    expect(ln1).to_not be_root

    ln2 = LeafNode.new("2", ta)
    tb  = TreeNode.new("b", ta)
    ln3 = LeafNode.new("3", tb)
    expect(ln3.parent).to be == tb

    # test depth
    expect(tb.depth).to be == 2
    expect(ln3.depth).to be == 3

    # test nr_nodes
    expect(tb.nr_nodes).to be == 1
    expect(ta.nr_nodes).to be == 4

    # puts ta.to_str
  end

  it "should add child and leaf" do
    ta = TreeNode.new("a")
    expect(ta).to be_root

    ln1 = LeafNode.new("1")
    ta.add_leaf(ln1)
    expect(ln1.parent).to be == ta

    ln2 = LeafNode.new("2", ta)
    ta.add_leaf(ln2)

    tb  = TreeNode.new("b", ta)
    ln3 = LeafNode.new("3", tb)
    tb.add_leaf(ln3)
    expect(ln3.parent).to be == tb

    ta.add_child(tb)
    # puts ta.to_str
  end

  it "next and prev" do
    ta = TreeNode.new("a")
    expect(ta.prev).to be_nil
    expect(ta.next).to be_nil

    ln1 = LeafNode.new("1", ta)
    expect(ln1.prev).to be_nil
    expect(ln1.next).to be_nil

    ln2 = LeafNode.new("2", ta)
    expect(ln2.prev).to be == ln1
    expect(ln2.next).to be_nil

    ln3 = LeafNode.new("3", ta)
    expect(ln2.next).to be == ln3

    tb = TreeNode.new("b", ta)
    expect(tb.next).to be_nil
    expect(tb.prev).to be_nil

    tc = TreeNode.new("c", ta)
    expect(tc.prev).to be == tb
    expect(tc.next).to be_nil
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
      expect(@tree.nr_nodes).to be == 5
      expect(@tree.nr_leaves).to be == 4
      expect(@tree.nr_children).to be == 1

      expect(@sub_tree.nr_nodes).to be == 2
      expect(@sub_tree.nr_leaves).to be == 2
      expect(@sub_tree.nr_children).to be == 0
    end


    context "find" do

      it "find by string" do
        expect(@tree.find("a")).to be === @tree
        expect(@tree.find("b")).to be === @sub_tree
        expect(@tree.find("3")).to be === @ln3
        expect(@tree.find("not existent")).to be_nil
      end

      it "find by regex" do
        expect(@tree.find(/[a,b]/)).to be === @tree
        expect(@tree.find(/[b,c]/)).to be === @sub_tree
        expect(@tree.find(/\d\d/)).to be === @ln4
        expect(@tree.find(/not existent/)).to be_nil
      end

      it "find with block" do
        expect(@tree.find { |e| e.content == "a" }).to be === @tree
        expect(@tree.find { |e| e.content == "b" }).to be === @sub_tree
        expect(@tree.find { |e| e.content == "3" }).to be === @ln3
        expect(@tree.find { |e| e.content == "not existent" }).to be_nil
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
        expect(@tree.to_str).to be == out
      end

    end

  end
end
