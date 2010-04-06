module TreeVisitor
  #
  # Clone a tree_node
  #
  class CloneTreeNodeVisitor < TreeNodeVisitor

    attr_reader :cloned_root

    def initialize
      super
      @cloned_root = nil
      @stack = []
    end

    def enter_tree_node( treeNode )
      if @stack.empty?
        cloned_tree_node = TreeNode.new( treeNode.name )
        @cloned_root = cloned_tree_node
      else
        cloned_tree_node = TreeNode.new( treeNode.name, @stack.last )
      end
      @stack.push( cloned_tree_node )
    end

    def exit_tree_node( treeNode )
      @stack.pop
    end

    def visit_leaf_node( leaf_node )
      LeafNode.new( leaf_node.name, @stack.last )
    end

  end
end
