#
#
#
class DepthTreeNodeVisitor < TreeNodeVisitor

  attr_reader :depth

  def initialize
    super
    @depth = 0
  end

  def enter_treeNode( treeNode )
    @depth += 1
  end

  def exit_treeNode( treeNode )
    @depth -= 1
  end

  def visit_leafNode( leafNode )
  end

end
