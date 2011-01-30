# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe TreeNode do

  context "paths" do

    before do
      @tree     = TreeNode.new("a")
      ln1       = LeafNode.new("1", @tree)
      ln2       = LeafNode.new("2", @tree)
      @sub_tree = TreeNode.new("b", @tree)
      @ln3      = LeafNode.new("3", @sub_tree)
      @ln4      = LeafNode.new("12", @sub_tree)
    end

    it "correct path" do
      @tree.path.should == "a"
      @sub_tree.path.should == "a/b"
      @tree.path_with_prefix.should == "a"
      @sub_tree.path_with_prefix.should == "a/b"
    end

    it "assign prefix path with a /" do
      @tree.prefix_path= "<root>/"

      @tree.prefix_path.should == "<root>/"
      @tree.path.should == "a"
      @sub_tree.path.should == "a/b"
      @tree.path_with_prefix.should == "<root>/a"
      @sub_tree.path_with_prefix.should == "<root>/a/b"
    end

    it "assign empty prefix path" do
      @tree.prefix_path= ""

      @tree.prefix_path.should == "/"
      @tree.path.should == "a"
      @sub_tree.path.should == "a/b"
      @tree.path_with_prefix.should == "/a"
      @sub_tree.path_with_prefix.should == "/a/b"
    end

    it "assign prefix path wo a /" do
      @tree.prefix_path= "<root>"

      @tree.prefix_path.should == "<root>/"
      @tree.path_with_prefix.should == "<root>/a"
      @sub_tree.path_with_prefix.should == "<root>/a/b"
    end

    it "invalidate" do
      @tree.prefix_path="root/"
      @sub_tree.path.should == "a/b"
      @sub_tree.path_with_prefix.should == "root/a/b"
      @sub_tree.depth.should == 2

      r = TreeNode.new("r")
      r.add_child(@tree)
      @sub_tree.path.should == "r/a/b"
      @sub_tree.path_with_prefix.should == "r/a/b"

      r.prefix_path="new_root/"
      @sub_tree.path.should == "r/a/b"
      @sub_tree.path_with_prefix.should == "new_root/r/a/b"
      @sub_tree.depth.should == 3
    end

  end
end