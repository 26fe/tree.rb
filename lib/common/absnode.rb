# rubygems
require "rubygems"
require "abstract"

#
# Nodo Astratto
#   Gerarchia delle classi
#
#   AbsNode ha un nome, un parent
#    |      definisce un path
#    |
#    |- LeafNode
#    |
#    |- TreeNode
# 
#
class AbsNode

  attr_reader :parent
  attr_reader :name

  def initialize( name )
    @parent = nil
    @name = name
    @path = nil
    @depth = nil
  end

  def path
    return @path unless @path.nil?
    if @parent.nil?
      @path = @name
    else
      @path = File.join( @parent.path, @name )
    end
    @path
  end
  
  def depth
    return @depth unless @depth.nil?
    if @parent.nil?
      @depth = 1
    else
      @depth = @parent.depth + 1
    end
    @depth
  end
  
  def accept( visitor )
    not_implemented
  end

  protected

  def parent=( parent )
    @parent = parent
  end

end
