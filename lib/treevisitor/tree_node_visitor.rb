# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # More complex TreeNodeVisitor
  #
  class TreeNodeVisitor

    def initialize(&block)
      if block
        instance_eval(&block)
      end
    end

    #
    # called on tree node at start of the visit i.e. we start to visit the subtree
    #
    def enter_tree_node(tree_node)
      @on_enter_tree_node_block.call(tree_node)
    end

    #
    # called on tree node at end of the visit i.e. oll subtree are visited
    #
    def exit_tree_node(tree_node)
      @on_exit_tree_node_block.call(tree_node)
    end

    #
    # called when visit leaf node
    #
    def visit_leaf_node(leaf_node)
      @on_visit_leaf_node_block.call(leaf_node)
    end

    private

    def on_enter_tree_node(&block)
      raise "block missing" unless block
      @on_enter_tree_node_block = block
    end

    def on_exit_tree_node(&block)
      raise "block missing" unless block
      @on_exit_tree_node_block = block
    end

    def on_visit_leaf_node(&block)
      raise "block missing" unless block
      @on_visit_leaf_node_block = block
    end

  end

end
