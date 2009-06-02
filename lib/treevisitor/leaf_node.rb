# common
require "treevisitor/abs_node"

#
# Deriva da AbsNode
# 
# definisce un metodo to_str
#
#
class LeafNode < AbsNode

  def initialize( name, parent = nil )
    super( name )
    if parent
      parent.add_leaf( self ) 
    end
  end

  def root?
    false
  end

  def accept( visitor )
    visitor.visit_leaf_node( self )
  end

  def to_str
    name.to_str
  end

end
