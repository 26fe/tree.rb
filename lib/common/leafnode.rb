
require "common/absnode"

class LeafNode < AbsNode

  def initialize( parent, name )
    super( name )
    parent.add_leaf( self )
  end

  def accept( visitor )
    visitor.visit_leafNode( self )
  end

  def to_str
    "item #@name"
  end

end
