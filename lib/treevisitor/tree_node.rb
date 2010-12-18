# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # TreeNode can contains other TreeNode (children)
  # and can contains LeafNode (leaves)
  #
  # TreeNode @children -1---n-> TreeNode
  #          @leaves   -1---n-> LeafNode
  #
  class TreeNode < AbsNode

    class << self

      def create(class1 = TreeNode, class2 = LeafNode, &block)
        if class1.ancestors.include?(TreeNode) and class2.ancestors.include?(LeafNode)
          @tree_node_class = class1
          @leaf_node_class = class2
        elsif class1.ancestors.include?(LeafNode) and class2 == LeafNode
          @tree_node_class = self
          @leaf_node_class = class1
        end

        if @tree_node_class.nil? || @leaf_node_class.nil?
          raise "Must be specified class derived from TreeNode and LeafNode"
        end

        @scope_stack = []
        class_eval(&block)
      end

      private

      def node(*args, &block)
        parent_node = @scope_stack.length > 0 ? @scope_stack[-1] : nil
        args << parent_node
        tree_node = @tree_node_class.new(*args)
        @scope_stack.push tree_node
        if block
          if block.arity == 0 || block.arity == -1
            class_eval(&block)
          elsif block.arity == 1
            new_block = Proc.new { block.call(tree_node) }
            class_eval(&new_block)
          else
            raise "block take too much arguments #{block.arity}"
          end
        end
        @scope_stack.pop
      end

      def leaf(*args, &block)
        tree_node = @scope_stack[-1]
        args << tree_node
        leaf_node = @leaf_node_class.new(*args)
        if block
          if block.arity == 0 || block.arity == -1
            class_eval(&block)
          elsif block.arity == 1
            new_block = Proc.new { block.call(leaf_node) }
            class_eval(&new_block)
          else
            raise "block take too much arguments #{block.arity}"
          end
        end
        leaf_node
      end
    end

    attr_reader :leaves
    attr_reader :children

    #
    # @param [Object] content of this node
    #
    def initialize(content, parent = nil)
      @leaves   = []
      @children = []
      super(content)
      parent.add_child(self) if parent
    end

    #
    # Test if is a root
    #
    def root?
      @parent.nil?
    end

    #
    # invalidate cached info
    # invalidate propagates form parent to children and leaves
    #
    def invalidate
      super
      @children.each { |c| c.invalidate }
      @leaves.each { |l| l.invalidate }
    end

    #
    # @return [FixNum] total number of nodes
    #
    def nr_nodes
      nr = @leaves.length + @children.length
      @children.inject(nr) { |sum, c| sum + c.nr_nodes }
    end

    #
    # @return [FixNum] total number of leaves
    #
    def nr_leaves
      @leaves.length + @children.inject(0) { |sum, child| sum + child.nr_leaves }
    end

    #
    # @return [FixNum] total number of children
    #
    def nr_children
      @children.length + @children.inject(0) { |sum, child| sum + child.nr_children }
    end

    #
    # Add a Leaf
    # @param [LeafNode]
    #
    # @return self
    #
    def add_leaf(leaf)
      return if leaf.parent == self
      if not leaf.parent.nil?
        leaf.remove_from_parent
      end
      leaf.parent = self
      if @leaves.length > 0
        @leaves.last.next = leaf
        leaf.prev         = @leaves.last
      else
        leaf.prev = nil
      end
      leaf.next = nil
      leaf.invalidate
      @leaves << leaf
      self
    end

    #
    # Add a Tree
    # @param [LeafNode]
    #
    # @return self
    #
    def add_child(tree_node)
      return if tree_node.parent == self
      if not tree_node.parent.nil?
        tree_node.remove_from_parent
      else
        tree_node.prefix_path = nil
      end
      tree_node.invalidate
      tree_node.parent = self
      if @children.length > 0
        @children.last.next = tree_node
        tree_node.prev      = @children.last
      else
        tree_node.prev = nil
      end
      tree_node.next = nil
      @children << tree_node
      self
    end

    #
    # Find a node down the hierarchy with content
    # @param [Object] content of searched node
    # @return [Object, nil] nil if no
    #
    def find(content = nil, &block)
      if content and block_given?
        raise "TreeNode::find - passed content AND block"
      end

      if content
        block = proc { |c| c == content }
      end
      return self if block.call(self.content)

      leaf = @leaves.find { |l| block.call(l.content) }
      return leaf if leaf

      @children.each do |child|
        node = child.find &block
        return node if node
      end
      nil
    end

    #
    # return the visitor
    #
    def accept(visitor)
      visitor.enter_tree_node(self)
      @leaves.each { |leaf|
        leaf.accept(visitor)
      }
      @children.each { |child|
        child.accept(visitor)
      }
      visitor.exit_tree_node(self)
      visitor
    end

    #
    # Format the content of tree
    #
    def to_str(prefix= "")
      str = ""

      if root?
        str << to_s << "\n"
      else
        str << prefix
        if self.next
          str << '|-- '
        else
          str << '`-- '
        end
        str << to_s << "\n"
        prefix += self.next ? "|   " : "    "
      end

      @leaves.each do |leaf|
        str << prefix
        if !leaf.next.nil? or !@children.empty?
          str << '|-- '
        else
          str << '`-- '
        end
        str << leaf.to_s << "\n"
      end

      @children.each do |child|
        str << child.to_str(prefix)
      end
      str
    end

  end
end
