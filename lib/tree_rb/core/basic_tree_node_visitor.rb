# -*- coding: utf-8 -*-
module TreeRb
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

    #
    # called when the tree node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_enter_node( tree_node, error)
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

    #
    # called when the leaf node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_visit_leaf( tree_node, error)
    end
  end

end
