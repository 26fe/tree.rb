# -*- coding: utf-8 -*-
module TreeRb
  #
  # Clone a tree_node, nodes are duplicated.
  # Node content are not duplicated!
  #
  class CloneTreeNodeVisitor # < BasicTreeNodeVisitor

    #
    # Contains the cloned tree node after the visit
    #
    attr_reader :cloned_root

    def initialize
      super
      @cloned_root = nil
      @stack = []
    end

    def enter_node( tree_node )
      if @stack.empty?
        cloned_tree_node = TreeNode.new( tree_node.content )
        @cloned_root = cloned_tree_node
      else
        cloned_tree_node = TreeNode.new( tree_node.content, @stack.last )
      end
      @stack.push( cloned_tree_node )
    end

    def exit_node( tree_node )
      @stack.pop
    end

    #
    # called when the tree node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_enter_node( tree_node, error)
    end

    def visit_leaf( leaf_node )
      LeafNode.new( leaf_node.content, @stack.last )
    end

  end
end
