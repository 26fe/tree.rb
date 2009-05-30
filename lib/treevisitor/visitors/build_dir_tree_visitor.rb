# common
require 'treevisitor/tree_node'
require 'treevisitor/dir_tree_walker'
require 'treevisitor/tree_node_visitor'

#
# costruisce una albero TreeNode a partire dalla struttura
# della directory, simile a clona
# Clona un TreeNode
#
class BuildDirTreeVisitor < TreeNodeVisitor
  
  attr_reader :root

  attr_reader :nr_directories
  attr_reader :nr_files
  
  def initialize
    super
    @root = nil
    @stack = []
    @nr_directories = 0
    @nr_files = 0
  end
  
  def enter_treeNode( pathname )
    if @stack.empty?
      treeNode = TreeNode.new( File.basename( pathname ) )
      @root = treeNode
    else
      treeNode = TreeNode.new( File.basename( pathname ), @stack.last )
    end
    @nr_directories += 1
    @stack.push( treeNode )
  end

  def exit_treeNode( pathname )
    @stack.pop
  end

  def visit_leafNode( pathname )
    @nr_files  += 1
    leafNode = LeafNode.new( File.basename(pathname), @stack.last )
  end

end
