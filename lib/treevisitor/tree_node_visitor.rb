# rubygems
require 'rubygems'
require 'abstract'

#
# Classe astratta per visitare un TreeNode
#
class TreeNodeVisitor

  def enter_tree_node( treeNode )
    not_implemented
  end

  def exit_tree_node( treeNode )
    not_implemented
  end

  def visit_leaf_node( leafNode )
    not_implemented
  end

end








  
