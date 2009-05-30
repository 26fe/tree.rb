
#
# CallbackTreeNodeVisitor
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

  def enter_treeNode( treeNode )
    newParentNode = if @stack.empty?
                      nil
                    else
                      @stack.last
                    end
    newTreeNode = @action_enterTreeNode.call( treeNode, newParentNode )
    @root = newTreeNode if @stack.empty?
    @stack.push( newTreeNode )
  end

  def exit_treeNode( treeNode )
    @stack.pop
  end

  def visit_leafNode( leafNode )
    newParentNode = @stack.last
    @action_visitLeafNode.call( leafNode, newParentNode )
  end

end

