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
  
  # solo TreeNode puo' scrivere vedi funzione add_leaf
  attr_accessor :prev
  attr_accessor :next

  def initialize( name )
    @parent = nil
    @name = name
    @prefix_path = nil
    invalidate
  end
  
  #
  # invalidate cached info
  #
  def invalidate
    @path = nil
    @path_from_root = nil
    @depth = nil    
  end
  
  def prefix_path=( prefix )
    if not @parent.nil?
      raise "Not root!!"
    end
    if prefix != @prefix_path
      @prefix_path = prefix
      invalidate
    end
  end

  def path
    return @path unless @path.nil?
    if @parent.nil?
      if @prefix_path
        @path = @prefix_path + @name
      else
        @path = @name
      end
    else
      @path = File.join( @parent.path, @name )
    end
    @path
  end
  
  def path_from_root
    return @path_from_root unless @path_from_root.nil?
    if @parent.nil?
      if @prefix_path
        @path_from_root = @prefix_path
      else
        @path_from_root = ""
      end
    else
      @path_from_root = File.join( @parent.path_from_root, @name )
    end
    @path_from_root
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
