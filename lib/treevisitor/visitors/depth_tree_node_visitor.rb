# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Simple visitor: show how calculate the depth of a tree
  #
  class DepthTreeNodeVisitor < TreeNodeVisitor

    attr_reader :depth

    def initialize
      super
      @depth = 0
    end

    def enter_tree_node( tree_node )
      @depth += 1
    end

    def exit_tree_node( tree_node )
      @depth -= 1
    end

    def visit_leaf_node( leaf_node )
    end

  end
end
