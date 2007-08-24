# common
require "common/absnode"

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

  def accept( visitor )
    visitor.visit_leafNode( self )
  end

  def to_str
    name.to_str
  end

end
