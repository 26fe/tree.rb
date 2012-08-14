# -*- coding: utf-8 -*-

module TreeVisitor
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

    def visit_leaf(pathname)
      @node[File.basename(pathname)] = File.stat(pathname).size
    end

  end
end
