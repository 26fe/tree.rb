# -*- coding: utf-8 -*-
module TreeRb

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

    # @param [Object] delegate
    def initialize(delegate = nil, &block)
      @on_enter_tree_node_blocks = []
      @on_exit_tree_node_blocks  = []
      @on_visit_leaf_node_blocks = []
      @stack                     = []
      @root                      = nil
      @delegate                  = delegate
      if block
        instance_eval(&block)
      end
    end

    #
    # called on tree node at start of the visit i.e. we start to visit the subtree
    #
    def enter_node(tree_node)
      parent = @stack.last
      if @delegate
        @delegate.enter_node(tree_node) if @delegate.respond_to? :enter_node
      else
        @on_enter_tree_node_blocks.each do |b|
          if b.arity == 1
            b.call(tree_node)
          elsif b.arity == 2
            b.call(tree_node, parent)
          end
        end
      end
      @root = tree_node if @stack.empty?
      @stack.push(tree_node)
    end

    #
    # called on tree node at end of the visit i.e. oll subtree are visited
    #
    def exit_node(tree_node)
      parent = @stack.last
      if @delegate
        @delegate.exit_node(tree_node) if @delegate.respond_to? :exit_node
      else
        @on_exit_tree_node_blocks.each do |b|
          if b.arity == 1
            b.call(tree_node)
          elsif b.arity == 2
            b.call(tree_node, parent)
          end
        end
      end
      @stack.pop
    end

    #
    # called when visit leaf node
    #
    def visit_leaf(leaf_node)
      parent = @stack.last
      if @delegate
        @delegate.visit_leaf(leaf_node) if @delegate.respond_to? :visit_leaf
      else
        @on_visit_leaf_node_blocks.each do |b|
          if b.arity == 1
            b.call(leaf_node)
          elsif b.arity == 2
            b.call(leaf_node, parent)
          end
        end
      end
    end

    #
    # add a block to be called when entering into a tree_node
    #
    def on_enter_node(&block)
      raise "already defined a delegate" if @delegate
      raise "block missing" unless block
      @on_enter_tree_node_blocks << block
    end

    #
    # add a block to be called when exiting from a TreeNode
    #
    def on_exit_node(&block)
      raise "already defined a delegate" if @delegate
      raise "block missing" unless block
      @on_exit_tree_node_blocks << block
    end

    #
    # add a block to be called when visiting a leaf node
    #
    def on_leaf(&block)
      raise "already defined a delegate" if @delegate
      raise "block missing" unless block
      @on_visit_leaf_node_blocks << block
    end

  end

end
