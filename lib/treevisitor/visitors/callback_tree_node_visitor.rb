#
# CallbackTreeNodeVisitor
#
class CallbackTreeNodeVisitor < TreeNodeVisitor

  def initialize( root = nil )
    super()
    @stack = []
    @root = root
    @stack.push( root ) if root
    @action_enterTreeNode = nil
    @action_visitLeafNode = nil
  end

  def onEnterTreeNode( &action )
    @action_enterTreeNode = action
  end

  def onVisitLeafNode( &action )
    @action_visitLeafNode = action
  end

  def enter_treeNode( treeNode )
    parentNode = if @stack.empty?
                   nil
                 else
                   @stack.last
                 end
    @root = treeNode if @stack.empty?
    @stack.push( treeNode )
    @action_enterTreeNode.call( treeNode ) if @action_enterTreeNode
  end

  def exit_treeNode( treeNode )
    @stack.pop
  end

  def visit_leafNode( leafNode )
    parentNode = @stack.last
    @action_visitLeafNode.call( leafNode ) if @action_visitLeafNode
  end

end
