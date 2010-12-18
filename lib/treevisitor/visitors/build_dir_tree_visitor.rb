# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Builds a TreeNode from a filesystem directory
  # It similar to CloneTreeNodeVisitor
  #
  class BuildDirTreeVisitor < TreeNodeVisitor
  
    attr_reader :root

    #
    # Number of visited directory (aka nr_nodes - nr_leaf)
    #
    attr_reader :nr_directories


    #
    # Number of visited directory (nr_leaves)
    # @see AbsNode#nr_leaves
    #
    attr_reader :nr_files
  
    def initialize
      super
      @root = nil
      @stack = []
      @nr_directories = 0
      @nr_files = 0
    end
  
    def enter_tree_node( pathname )
      if @stack.empty?
        tree_node = TreeNode.new( File.basename( pathname ) )
        @root = tree_node
      else
        tree_node = TreeNode.new( File.basename( pathname ), @stack.last )
      end
      @nr_directories += 1
      @stack.push( tree_node )
    end

    def exit_tree_node( pathname )
      @stack.pop
    end

    def visit_leaf_node( pathname )
      @nr_files  += 1
      # connect the leaf_node created to the last tree_node on the stack
      LeafNode.new( File.basename(pathname), @stack.last )
    end

  end
end
