# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Executes a block when enter in a node
  # The block are defined from on_enter_X methods
  # The blocks take as argument the node and the parent_node
  #
  class CallbackTreeNodeVisitor2

    attr_reader :root

    def initialize(delegate = nil)
      super()
      @stack    = []
      @root     = nil
      @delegate = delegate
    end

    def on_enter_node(&block)
      raise "already defined a delegate" if @delegate
      @action_enter_tree_node = block
    end

    def on_visit_leaf(&block)
      raise "already defined a delegate" if @delegate
      @action_visit_leaf_node = block
    end

    def enter_node(src_tree_node)
      dst_parent_node = @stack.empty? ? nil : @stack.last
      dst_tree_node = @action_enter_tree_node.call(src_tree_node, dst_parent_node) if @action_enter_tree_node
      dst_tree_node = @delegate.enter_node(src_tree_node, dst_parent_node) if @delegate and @delegate.respond_to? :enter_node
      @root = dst_tree_node if @stack.empty?
      @stack.push(dst_tree_node)
    end

    def exit_node(src_tree_node)
      @stack.pop
    end

    def visit_leaf(src_leaf_node)
      parent_node = @stack.last
      @action_visit_leaf_node.call(src_leaf_node, parent_node) if @action_visit_leaf_node
      @delegate.visit_leaf(src_leaf_node, parent_node) if @delegate and @delegate.respond_to? :visit_leaf
    end
  end

end
