# rubygems
require "rubygems"
require "abstract"

#
# Abstract Node
#   Class hierarchy
#
#   AbsNode has a name, a parent
#    ^      and define a path i.e. concatenation ancestor names
#    |
#    |-- LeafNode
#    |
#    `-- TreeNode
#
#  Object diagram
#
#           TreeNode (parent: nil)
#             |
#             |--->[ LeafNode, LeafNode, LeafNode ]
#             |
#             |--->[ TreeNode, TreeNode ]
#                         |
#                         |--> [LeafNode]
#                         |
#                         `--> [TreeNode, TreeNode]
class AbsNode

  class << self
    attr_accessor :path_separator
  end
  self.path_separator = File::SEPARATOR

  attr_reader :parent
  attr_reader :name
  
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
    @path_with_prefix = nil
    @depth = nil    
  end
  
  def prefix_path
    if not @parent.nil?
      raise "Not root!!"
    end
    @prefix_path
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

  def root
    if root?
      self
    else
      parent.root
    end
  end
  
  def path
    return @path unless @path.nil?
    if @parent.nil?
      @path = @name
    else
      @path = @parent.path + AbsNode::path_separator + @name
    end
    @path
  end
  
  def path_with_prefix
    return @path_with_prefix unless @path_with_prefix.nil?
    if @parent.nil?
      @path_with_prefix = @prefix_path.nil? ? @name : @prefix_path + @name
    else
      @path_with_prefix = @parent.path_with_prefix + AbsNode::path_separator + @name
    end
    @path_with_prefix
  end

  def depth
    return @depth unless @depth.nil?
    @depth = @parent.nil? ? 1 : @parent.depth + 1
    @depth
  end
  
  def accept( visitor )
    not_implemented
  end

  def to_s
    @name.to_s
  end

  protected

  def parent=( parent )
    @parent = parent
  end

end
