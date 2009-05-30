#
# Esempio
# Clona un TreeNode
#
class CloneTreeNodeVisitor < TreeNodeVisitor

  attr_reader :clonedRoot

  def initialize
    super
    @clonedRoot = nil
    @stack = []
  end

  def enter_treeNode( treeNode )
    if @stack.empty?
      clonedTreeNode = TreeNode.new( treeNode.name )
      @clonedRoot = clonedTreeNode
    else
      clonedTreeNode = TreeNode.new( treeNode.name, @stack.last )
    end
    @stack.push( clonedTreeNode )
  end

  def exit_treeNode( treeNode )
    @stack.pop
  end

  def visit_leafNode( leafNode )
    clonedLeafNode = LeafNode.new( leafNode.name, @stack.last )
  end

end
