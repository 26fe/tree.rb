# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # It calls a block when visit a tree_node or leaf_node
  #
  class BlockTreeNodeVisitor < BasicTreeNodeVisitor

    def initialize( &action )
      @block = action
    end

    def enter_node( tree_node )
      @block.call( tree_node )
    end

    def visit_leaf( leaf_node )
      @block.call( leaf_node )
    end

  end
end
