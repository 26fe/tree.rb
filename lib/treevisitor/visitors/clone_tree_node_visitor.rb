# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Clone a tree_node, nodes are duplicated.
  # Node content are not duplicated!
  #
  class CloneTreeNodeVisitor < TreeNodeVisitor

    #
    # Contains the cloned tree node after the visit
    #
    attr_reader :cloned_root

    def initialize
      super
      @cloned_root = nil
      @stack = []
    end

    def enter_tree_node( tree_node )
      if @stack.empty?
        cloned_tree_node = TreeNode.new( tree_node.content )
        @cloned_root = cloned_tree_node
      else
        cloned_tree_node = TreeNode.new( tree_node.content, @stack.last )
      end
      @stack.push( cloned_tree_node )
    end

    def exit_tree_node( tree_node )
      @stack.pop
    end

    def visit_leaf_node( leaf_node )
      LeafNode.new( leaf_node.content, @stack.last )
    end

  end
end
