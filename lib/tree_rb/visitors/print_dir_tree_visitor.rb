# -*- coding: utf-8 -*-
module TreeRb
  #
  # Visitor for DirTreeWalker
  # Prints the node at enter
  # TODO: join this con PrintTreeNodeVisitor
  class PrintDirTreeVisitor # < BasicTreeNodeVisitor

    def enter_node( pathname )
      puts pathname
    end

    def exit_node( pathname )
    end

    #
    # called when the tree node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_enter_node( tree_node, error)
    end

    def visit_leaf( pathname )
      puts pathname
    end

  end
end
