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

    def visit_leaf( pathname )
      puts pathname
    end

  end
end
