#
# Prints node using "to_s" instead of name
# TODO: join this with PrintTreeNodeVisitor
class PrintTreeNodeVisitor2 < TreeNodeVisitor

  def initialize( *args )
    super( *args )
    @depth = 0
  end

  def visit_leaf_node( leaf_node )
    str = ""
    (0...@depth-1).step {
      str << " |-"
    }
    str << " |  "
    puts str + leaf_node.to_s
  end

  def enter_tree_node( tree_node )

    str = ""
    (0...@depth).step {
      str << " |-"
    }

    if @depth == 0
      puts str + tree_node.to_s
    else
      puts str + tree_node.to_s
    end
    @depth += 1
  end

  def exit_tree_node( tree_node )
    @depth -= 1
  end
end
