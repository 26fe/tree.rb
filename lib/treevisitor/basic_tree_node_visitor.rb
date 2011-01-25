# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Callback methods used to visit a tree
  # Are empty so it is possible to define only a subset when deriving subclass
  #
  class BasicTreeNodeVisitor

    #
    # called on tree node at start of the visit i.e. we start to visit the subtree
    #
    def enter_node( tree_node )
    end

    # alias :enter_tree_node :enter_node

    #
    # called on tree node at end of the visit i.e. oll subtree are visited
    #
    def exit_node( tree_node )
    end

    # alias :exit_tree_node :exit_node

    #
    # called when visit leaf node
    #
    def visit_leaf( leaf_node )
    end

    # alias :visit_leaf_node :visit_leaf
  end

end
