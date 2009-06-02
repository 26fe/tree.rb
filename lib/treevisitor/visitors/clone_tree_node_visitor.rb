#
# Clone a tree_node
#
class CloneTreeNodeVisitor < TreeNodeVisitor

  attr_reader :clonedRoot

  def initialize
    super
    @clonedRoot = nil
    @stack = []
  end

  def enter_tree_node( treeNode )
    if @stack.empty?
      clonedTreeNode = TreeNode.new( treeNode.name )
      @clonedRoot = clonedTreeNode
    else
      clonedTreeNode = TreeNode.new( treeNode.name, @stack.last )
    end
    @stack.push( clonedTreeNode )
  end

  def exit_tree_node( treeNode )
    @stack.pop
  end

  def visit_leaf_node( leafNode )
    clonedLeafNode = LeafNode.new( leafNode.name, @stack.last )
  end

end
