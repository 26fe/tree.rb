# common
require 'common/tree_node_visitor'

#
# costruisce una albero TreeNode a partire dalla struttura
# della directory, simile a clona
# Clona un TreeNode
#
class WxDirTreeVisitor < TreeNodeVisitor
      
  def initialize( guictrl ) 
    super()
    
    @guictrl = guictrl
    @root_id = nil      
    @stack = []
  end
  
  def enter_treeNode( pathname )
    if @stack.empty?
      guinode_id = @guictrl.add_root( File.basename( pathname ) ) 
      @root_id = guinode_id
    else
      guinode_id = @guictrl.append_item(@stack.last, File.basename( pathname ) )
    end
     @stack.push( guinode_id )
  end

  def exit_treeNode( pathname )
    @stack.pop
  end

  def visit_leafNode( pathname )
    guinode_id = @guictrl.append_item(@stack.last, File.basename( pathname ) )
  end

end

