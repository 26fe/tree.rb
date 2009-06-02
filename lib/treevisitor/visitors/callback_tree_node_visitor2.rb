
#
# Executes a block when enter in a node
# The block are defined from on_enter_X methods
# The blocks take as argument the node and the parent_node
#
class CallbackTreeNodeVisitor2 < TreeNodeVisitor

  attr_reader :root

  def initialize( root = nil )
    super()
    @stack = []
    @root = root
    @stack.push( root ) if root
  end

  def onEnterTreeNode( &action )
    @action_enterTreeNode = action
  end

  def onVisitLeafNode( &action )
    @action_visitLeafNode = action
  end

  def enter_tree_node( treeNode )
    newParentNode = if @stack.empty?
                      nil
                    else
                      @stack.last
                    end
    newTreeNode = @action_enterTreeNode.call( treeNode, newParentNode )
    @root = newTreeNode if @stack.empty?
    @stack.push( newTreeNode )
  end

  def exit_tree_node( treeNode )
    @stack.pop
  end

  def visit_leaf_node( leafNode )
    newParentNode = @stack.last
    @action_visitLeafNode.call( leafNode, newParentNode )
  end

end

