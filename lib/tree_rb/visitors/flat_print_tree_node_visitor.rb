# -*- coding: utf-8 -*-
module TreeRb
  #
  # Print for every node the name
  #
  class FlatPrintTreeNodeVisitor # < BasicTreeNodeVisitor

    def enter_node( tree_node )
      puts tree_node.name
    end

    def exit_node( tree_node )
    end

    #
    # called when the tree node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_enter_node( tree_node, error)
    end

    def visit_leaf( leaf_node )
      puts leaf_node.name
    end

  end
end
