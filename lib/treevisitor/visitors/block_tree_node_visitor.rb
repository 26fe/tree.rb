require 'treevisitor/tree_node_visitor.rb'

#
# It call a block when visit a tree_node or leaf_node
#
class BlockTreeNodeVisitor < TreeNodeVisitor

  def initialize( &action )
    @block = action
  end

  def enter_tree_node( tree_node )
    @block.call( tree_node )
  end

  def exit_tree_node( tree_node )
  end

  def visit_leaf_node( leaf_node )
    @block.call( leaf_node )
  end

end
