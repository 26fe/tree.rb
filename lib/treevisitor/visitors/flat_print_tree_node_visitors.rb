#
# Utilizzo della classa astratta DirTreeProcessor
# per stampare i nodi di un TreeNode
#
class FlatPrintTreeNodeVisitor < TreeNodeVisitor

  def enter_treeNode( treeNode )
    puts treeNode.name
  end

  def exit_treeNode( treeNode )
  end

  def visit_leafNode( leafNode )
    puts leafNode.name
  end

end
