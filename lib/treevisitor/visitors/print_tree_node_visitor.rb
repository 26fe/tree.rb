class PrintTreeNodeVisitor < TreeNodeVisitor

  def initialize( *args )
    super( *args )
    @depth = 0
  end

  def visit_leafNode( leafNode )
    str = ""
    (0...@depth-1).step {
      str << " |-"
    }
    str << " |  "
    puts str + leafNode.name.to_s
  end

  def enter_treeNode( treeNode )

    str = ""
    (0...@depth).step {
      str << " |-"
    }

    if @depth == 0
      puts str + treeNode.name.to_s
    else
      puts str + treeNode.name.to_s
    end
    @depth += 1
  end

  def exit_treeNode( treeNode )
    @depth -= 1
  end
end
