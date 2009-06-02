require 'treevisitor/tree_node_visitor.rb'

#
# It call a block when visit a tree_node or leaf_node
#
class BlockTreeNodeVisitor < TreeNodeVisitor

  def initialize( &action )
    @block = action
  end

  def enter_tree_node( treeNode )
    @block.call( treeNode )
  end

  def exit_tree_node( treeNode )
  end

  def visit_leaf_node( leafNode )
    @block.call( leafNode )
  end

end
