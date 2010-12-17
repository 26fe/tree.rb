# -*- coding: utf-8 -*-
module TreeVisitor
  #
  # Prints TreeNode names indenting according to depth
  #
  class PrintTreeNodeVisitor < TreeNodeVisitor

    def initialize
      @depth = 0
    end

    def enter_tree_node( tree_node )
      str = ""
      (0...@depth).step {
        str << " |-"
      }

      if @depth == 0
        puts str + tree_node.name.to_s
      else
        puts str + tree_node.name.to_s
      end
      @depth += 1
    end

    def exit_tree_node( tree_node )
      @depth -= 1
    end

    def visit_leaf_node( leaf_node )
      str = ""
      (0...@depth-1).step {
        str << " |-"
      }
      str << " |  "
      puts str + leaf_node.name.to_s
    end

  end
end
