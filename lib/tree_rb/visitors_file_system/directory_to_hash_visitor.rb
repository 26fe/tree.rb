# -*- coding: utf-8 -*-

module TreeRb
  #
  # Build hash with directory structure
  #
  class DirectoryToHashVisitor # < TreeVisitor::BasicTreeNodeVisitor

    attr_reader :root

    def initialize(pathname)
      @stack = []
      @node = {}
      @root = @node
    end

    def enter_node(pathname)
      subnode                        = {}
      @node[File.basename(pathname)] = subnode
      @stack.push(@node)
      @node = subnode
    end

    def exit_node(pathname)
      @node = @stack.pop
    end

    #
    # called when the tree node is not accessible or an exception is raise when the node is accessed
    #
    def cannot_enter_node( tree_node, error)
    end

    def visit_leaf(pathname)
      @node[File.basename(pathname)] = File.stat(pathname).size
    end

  end
end
