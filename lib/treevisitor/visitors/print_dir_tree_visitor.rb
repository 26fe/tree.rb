module TreeVisitor
  #
  # Visitor for DirTreeWalker
  # Prints the node at enter
  # TODO: join this con PrintTreeNodeVisitor
  class PrintDirTreeVisitor < TreeNodeVisitor

    def enter_tree_node( pathname )
      puts pathname
    end

    def exit_tree_node( pathname )
    end

    def visit_leaf_node( pathname )
      puts pathname
    end

  end
end
