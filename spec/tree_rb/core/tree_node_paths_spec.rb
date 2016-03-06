# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

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
      expect(@tree.path).to be == "a"
      expect(@sub_tree.path).to be == "a/b"
      expect(@tree.path_with_prefix).to be == "a"
      expect(@sub_tree.path_with_prefix).to be == "a/b"
    end

    it "assign prefix path with a /" do
      @tree.prefix_path= "<root>/"

      expect(@tree.prefix_path).to be == "<root>/"
      expect(@tree.path).to be == "a"
      expect(@sub_tree.path).to be == "a/b"
      expect(@tree.path_with_prefix).to be == "<root>/a"
      expect(@sub_tree.path_with_prefix).to be == "<root>/a/b"
    end

    it "assign empty prefix path" do
      @tree.prefix_path= ""

      expect(@tree.prefix_path).to be == "/"
      expect(@tree.path).to be == "a"
      expect(@sub_tree.path).to be == "a/b"
      expect(@tree.path_with_prefix).to be == "/a"
      expect(@sub_tree.path_with_prefix).to be == "/a/b"
    end

    it "assign prefix path wo a /" do
      @tree.prefix_path= "<root>"

      expect(@tree.prefix_path).to be == "<root>/"
      expect(@tree.path_with_prefix).to be == "<root>/a"
      expect(@sub_tree.path_with_prefix).to be == "<root>/a/b"
    end

    it "invalidate" do
      @tree.prefix_path="root/"
      expect(@sub_tree.path).to be == "a/b"
      expect(@sub_tree.path_with_prefix).to be == "root/a/b"
      expect(@sub_tree.depth).to be == 2

      r = TreeNode.new("r")
      r.add_child(@tree)
      expect(@sub_tree.path).to be == "r/a/b"
      expect(@sub_tree.path_with_prefix).to be == "r/a/b"

      r.prefix_path="new_root/"
      expect(@sub_tree.path).to be == "r/a/b"
      expect(@sub_tree.path_with_prefix).to be == "new_root/r/a/b"
      expect(@sub_tree.depth).to be == 3
    end

  end
end
