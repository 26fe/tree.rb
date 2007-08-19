require 'abstract'

class TreeNodeVisitor

  def visit_leafNode( leafNode )
    not_implemented
  end

  def visit_treeNode( treeNode )
    not_implemented
  end

end

#
# Utilizzo della classa astratta DirTreeProcessor
# per visitare un albero di directory
#
class PrintTreeNodeVisitor < TreeNodeVisitor

  def initialize
    @depth = 0
  end

  def visit_leafNode( leafNode )
    puts leafNode.name
  end

  def visit_treeNode( treeNode )
    puts treeNode.name
  end

end