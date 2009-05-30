#
# Utilizzo della classa astratta DirTreeProcessor
# per stampare i nodi di un TreeNode
#
class PrintDirTreeVisitor < TreeNodeVisitor

  def enter_treeNode( pathname )
    puts pathname
  end

  def exit_treeNode( treeNode )
  end

  def visit_leafNode( pathname )
    puts pathname
  end

end
