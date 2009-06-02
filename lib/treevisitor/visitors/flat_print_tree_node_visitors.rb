#
# Print for every node the name
#
class FlatPrintTreeNodeVisitor < TreeNodeVisitor

  def enter_tree_node( treeNode )
    puts treeNode.name
  end

  def exit_tree_node( treeNode )
  end

  def visit_leaf_node( leafNode )
    puts leafNode.name
  end

end
