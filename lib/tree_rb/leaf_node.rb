# -*- coding: utf-8 -*-
module TreeVisitor

  #
  # Represent a LeafNode
  #
  class LeafNode < AbsNode

    #
    # @param [Object] content of node
    #
    def initialize( content, parent = nil )
      super( content )
      parent.add_leaf(self) if parent
    end

    #
    # @return false because a leaf_node cannot be a root
    #
    def root?
      false
    end

    #
    # @return [TreeNodeVisitor] the visitor
    #
    def accept( visitor )
      visitor.visit_leaf( self )
      visitor
    end

  end
end
