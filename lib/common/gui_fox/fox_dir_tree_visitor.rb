# common
require 'common/tree_node_visitor'

#
# costruisce una albero TreeNode a partire dalla struttura
# della directory, simile a clona
# Clona un TreeNode
#
class FoxDirTreeVisitor < TreeNodeVisitor
      
  def initialize( guitree, folder_open, folder_closed, doc )
    super()
    
    @guitree = guitree
    @folder_open = folder_open
    @folder_closed = folder_closed
    @doc = doc
      
    @root = nil
    @stack = []
  end
  
  def enter_treeNode( pathname )
    if @stack.empty?
      guinode = @guitree.appendItem(nil, File.basename( pathname ), @folder_open, @folder_closed)
      @guitree.expandTree(guinode)
      @root = guinode
    else
      guinode = @guitree.appendItem(@stack.last, File.basename( pathname ), @folder_open, @folder_closed)
      @guitree.expandTree(guinode)
    end
    @stack.push( guinode )
  end

  def exit_treeNode( pathname )
    @stack.pop
  end

  def visit_leafNode( pathname )
    guinode = @guitree.appendItem(@stack.last, File.basename( pathname ), @doc, @doc)
  end

end

