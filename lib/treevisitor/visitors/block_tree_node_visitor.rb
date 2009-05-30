require 'treevisitor/tree_node_visitor.rb'

#
# Utilizzo della classa astratta DirTreeProcessor
# per chimare un blocco su tutti i TreeNode
#
class BlockTreeNodeVisitor < TreeNodeVisitor

  def initialize( &action )
    @block = action
  end

  def enter_treeNode( treeNode )
    @block.call( treeNode )
  end

  def exit_treeNode( treeNode )
  end

  def visit_leafNode( leafNode )
    @block.call( leafNode )
  end

end
