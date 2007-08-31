# common
require 'common/tree_node_visitor'

#
# costruisce una albero TreeNode a partire dalla struttura
# della directory, simile a clona
# Clona un TreeNode
#
class GuiWxDirTreeVisitor < TreeNodeVisitor
      
  def initialize( guictrl, root_id, folder_open_id, folder_closed_id, folder_selected_id,
                           file_unselected_id, file_selected_id )
    super()
    
    @guictrl = guictrl
    @root_id = root_id
    @folder_open_id = folder_open_id
    @folder_closed_id = folder_closed_id
    @folder_selected_id = folder_selected_id
    @file_selected_id = file_selected_id
    @file_unselected_id = file_unselected_id
      
    @root = nil
    @stack = []
  end
  
  def enter_treeNode( pathname )
    if @stack.empty?
      guinode_id = @guictrl.append_item(@root_id, File.basename( pathname ), @folder_open_id, @folder_closed_id)
      @guictrl.set_item_image(guinode_id, @folder_open_id, Wx::TREE_ITEM_ICON_EXPANDED)
      @root = guinode_id
    else
      guinode_id = @guictrl.append_item(@stack.last, File.basename( pathname ), @folder_open_id, @folder_closed_id)
      @guictrl.set_item_image(guinode_id, @folder_open_id, Wx::TREE_ITEM_ICON_EXPANDED)
    end
    @guictrl.set_item_image(guinode_id, @folder_open_id, Wx::TREE_ITEM_ICON_EXPANDED)

    @stack.push( guinode_id )
  end

  def exit_treeNode( pathname )
    @stack.pop
  end

  def visit_leafNode( pathname )
    guinode_id = @guictrl.append_item(@stack.last, File.basename( pathname ), @file_unselected_id, @file_selected_id)
  end

end

