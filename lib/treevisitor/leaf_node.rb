# -*- coding: utf-8 -*-
module TreeVisitor
  class LeafNode < AbsNode

    def initialize( name, parent = nil )
      super( name )
      if parent
        parent.add_leaf( self )
      end
    end

    #
    # a leaf_node cannot be a root
    def root?
      false
    end

    #
    # return the visitor
    #
    def accept( visitor )
      visitor.visit_leaf_node( self )
      visitor
    end

  end
end
