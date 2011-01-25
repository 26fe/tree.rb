# -*- coding: utf-8 -*-
module TreeVisitor

  #
  # More complex TreeNodeVisitor, define a simple dsl
  # @example
  #   TreeNodeVisitor.new do
  #     on_enter_node do |node|
  #       puts "hello #{node}"
  #     end
  #     on_exit_node do |node|
  #       puts "bye #{node}"
  #     end
  #     on_leaf do |leaf|
  #       puts "how you do #{leaf}"
  #     end
  #   end
  #
  class TreeNodeVisitor

    def initialize(&block)

      @on_enter_tree_node_blocks = []
      @on_exit_tree_node_blocks  = []
      @on_visit_leaf_node_blocks = []

      @stack                     = []
      @root                      = nil

      if block
        instance_eval(&block)
      end
    end

    #
    # called on tree node at start of the visit i.e. we start to visit the subtree
    #
    def enter_node(tree_node)
      parent = @stack.last
      @on_enter_tree_node_blocks.each { |b| b.call(tree_node, parent) }
      @root = tree_node if @stack.empty?
      @stack.push(tree_node)
    end

    # alias :enter_tree_node :enter_node

    #
    # called on tree node at end of the visit i.e. oll subtree are visited
    #
    def exit_node(tree_node)
      parent = @stack.last
      @on_exit_tree_node_blocks.each { |b| b.call(tree_node, parent) }
      @stack.pop
    end

    # alias :exit_tree_node :exit_node

    #
    # called when visit leaf node
    #
    def visit_leaf(leaf_node)
      parent = @stack.last
      @on_visit_leaf_node_blocks.each { |b| b.call(leaf_node, parent) }
    end

    # alias :visit_leaf_node :visit_leaf

    #
    # add a block to be called when entering into a tree_node
    #
    def on_enter_node(&block)
      raise "block missing" unless block
      @on_enter_tree_node_blocks << block
    end

    # alias :on_enter_tree_node :on_enter_node

    #
    # add a block to be called when exiting from a TreeNode
    #
    def on_exit_node(&block)
      raise "block missing" unless block
      @on_exit_tree_node_blocks << block
    end

    # alias :on_exit_tree_node :on_exit_node

    #
    # add a block to be called when visiting a leaf node
    #
    def on_leaf(&block)
      raise "block missing" unless block
      @on_visit_leaf_node_blocks << block
    end

    # alias :on_visit_leaf_node :on_leaf

  end

end
