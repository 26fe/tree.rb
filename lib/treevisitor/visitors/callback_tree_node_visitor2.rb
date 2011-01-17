# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Executes a block when enter in a node
  # The block are defined from on_enter_X methods
  # The blocks take as argument the node and the parent_node
  #
  class CallbackTreeNodeVisitor2 < BasicTreeNodeVisitor

    attr_reader :root

    def initialize( delegate = nil)
      super()
      @stack = []
      @root = nil
      @delegate = delegate
    end

    def on_enter_tree_node( &action )
      @action_enter_tree_node = action
    end

    def on_visit_leaf_node( &action )
      @action_visit_leaf_node = action
    end

    def _on_enter_tree_node( src_tree_node, dst_parent_node )
      if @action_enter_tree_node
        dst_tree_node = @action_enter_tree_node.call( src_tree_node, dst_parent_node )
      elsif @delegate
        dst_tree_node = @delegate.on_enter_tree_node( src_tree_node, dst_parent_node )
      end
      dst_tree_node
    end

    def _on_visit_leaf_node( src_leaf_node, parent_node )
      if @action_visit_leaf_node
        @action_visit_leaf_node.call( src_leaf_node, parent_node )
      elsif @delegate
        @delegate.on_visit_leaf_node( src_leaf_node, parent_node )
      end
    end

    def enter_tree_node( src_tree_node )
      dst_parent_node = @stack.empty? ? nil : @stack.last
      dst_tree_node = _on_enter_tree_node( src_tree_node, dst_parent_node )
      @root = dst_tree_node if @stack.empty?
      @stack.push( dst_tree_node )
    end

    def exit_tree_node( src_tree_node )
      @stack.pop
    end

    def visit_leaf_node( src_leaf_node )
      parent_node = @stack.last
      _on_visit_leaf_node( src_leaf_node, parent_node )
    end
  end

end
