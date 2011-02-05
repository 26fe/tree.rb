## -*- coding: utf-8 -*-
#module TreeVisitor
#  #
#  # Executes a block when enter in a node
#  # The block are defined from on_enter_X methods
#  # The blocks take as argument only the node
#  #
#  class CallbackTreeNodeVisitor
#
#    def initialize(delegate = nil)
#      @root                   = nil
#      @stack                  = []
#      @action_enter_tree_node = nil
#      @action_visit_leaf_node = nil
#      @delegate               = delegate
#    end
#
#    def on_enter_node(&block)
#      raise "already defined a delegate" if @delegate
#      @action_enter_tree_node = block
#    end
#
#    def on_visit_leaf(&block)
#      raise "already defined a delegate" if @delegate
#      @action_visit_leaf_node = block
#    end
#
#    def enter_node(tree_node)
#      @root = tree_node if @stack.empty?
#      @stack.push(tree_node)
#      @action_enter_tree_node.call(tree_node) if @action_enter_tree_node
#      @delegate.enter_node(tree_node) if @delegate
#    end
#
#    def exit_node(tree_node)
#      @stack.pop
#    end
#
#    def visit_leaf(leaf_node)
#      @action_visit_leaf_node.call(leaf_node) if @action_visit_leaf_node
#      @delegate.visit_leaf(leaf_node) if @delegate
#    end
#
#  end
#end
