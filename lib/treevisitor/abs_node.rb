# -*- coding: utf-8 -*-
module TreeVisitor

  #
  # @abstract Subclass to implement a concrete Node (Leaf or Tree).
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
    attr_reader :content
  
    attr_accessor :prev
    attr_accessor :next

    #
    # Create a new AbsNode
    #
    # @param content of node
    #
    def initialize( content )
      @parent = nil
      @content = content
      @prefix_path = nil
      invalidate
    end
  
    #
    # invalidate cached path info
    #
    def invalidate
      @path = nil
      @path_with_prefix = nil
      @depth = nil
      @root = nil
    end

    #
    # Root node could have assigned a path
    #
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

    #
    # Return the root of this node
    #
    # @return AbsNode
    #
    def root
      return @root if @root
      @root = parent.nil? ? self : parent.root
    end

    #
    # @return [String] path to this node
    #
    def path
      return @path unless @path.nil?
      if @parent.nil?
        @path = @content
      else
        @path = @parent.path + AbsNode::path_separator + @content
      end
      @path
    end

    #
    # @return [String] path to this node with prefix
    #
    def path_with_prefix
      return @path_with_prefix unless @path_with_prefix.nil?
      if @parent.nil?
        @path_with_prefix = @prefix_path.nil? ? @content : @prefix_path + @content
      else
        @path_with_prefix = @parent.path_with_prefix + AbsNode::path_separator + @content
      end
      @path_with_prefix
    end

    #
    # @return [FixNum] depth of this node
    #
    def depth
      return @depth unless @depth.nil?
      @depth = @parent.nil? ? 1 : @parent.depth + 1
      @depth
    end

    #
    # Accept a node visitor
    #
    def accept( visitor )
      not_implemented
    end

    def to_s
      @content.to_s
    end

    protected

    def parent=( parent )
      @parent = parent
    end

  end
end