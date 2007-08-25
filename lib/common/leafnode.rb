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
    @path_from_root = nil
  end

  def accept( visitor )
    visitor.visit_leafNode( self )
  end

  def path_from_root
    return @path_from_root unless @path_from_root.nil?
    if @parent.nil?
      @path_from_root = "root"
    else
      @path_from_root = File.join( @parent.path_from_root, @name )
    end
    @path_from_root
  end

  def basename
    File.basename( @name )
  end

  def to_str
    name.to_str
  end

end
