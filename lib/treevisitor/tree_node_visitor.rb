# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Callback methods used to visit a tree
  # Are empty so it is possible to define only a subset
  #
  class TreeNodeVisitor

    #
    # called on tree node at start of the visit i.e. we start to visit the subtree
    #
    def enter_tree_node( tree_node )
    end

    #
    # called on tree node at end of the visit i.e. oll subtree are visited
    #
    def exit_tree_node( tree_node )
    end

    #
    # called when visit leaf node
    #
    def visit_leaf_node( leaf_node )
    end

  end

end
