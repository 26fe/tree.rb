require 'common/treenode'
require 'common/dirtree_processor'

#
# Esempio di utilizzo della classa astratta DirTreeProcessor
#
class PrintDirTreeProcessor < DirTreeProcessor

  def initialize( *args )
    super( *args )
  end

  protected

  def visit_file( treeNode, filename )
    filename
  end

  def visited_file( treeNode, attrNode )
    parentNode.add_value( attrNode )
  end

  def visit_dir( treeNode, dirname )
    TreeNode.new( dirname )
  end

  def visited_dir( parentNode, childNode )
    parentNode.add_child( childNode )
  end


end
