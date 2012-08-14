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

    def visit_leaf( leaf_node )
      puts leaf_node.name
    end

  end
end
