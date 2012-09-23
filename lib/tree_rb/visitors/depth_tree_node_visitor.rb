# -*- coding: utf-8 -*-
module TreeRb
  #
  # Simple visitor: show how calculate the depth of a tree
  #
  class DepthTreeNodeVisitor # < BasicTreeNodeVisitor

    attr_reader :depth

    def initialize
      @depth = 0
    end

    def enter_node( tree_node )
      @depth += 1
    end

    def exit_node( tree_node )
      @depth -= 1
    end

    #
    # called when the tree node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_enter_node( tree_node, error)
    end

    def visit_leaf( leaf_node )
    end

  end
end
