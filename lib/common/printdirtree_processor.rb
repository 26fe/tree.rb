require 'common/treenode'
require 'common/dirtree_processor'

#
# Esempio di utilizzo della classa astratta DirTreeProcessor
#
class PrintDirTreeProcessor < DirTreeProcessor

  def initialize( *args )
    super( *args )
    add_ignore_dir( ".svn" )
    add_ignore_dir( "catalog_data" )
  end

  protected

  def visit_file( filename )
    filename
  end

  def visited_file( parentNode, attrNode )
    parentNode.add_value( attrNode )
  end

  def visit_dir( dirname )
    TreeNode.new( dirname )
  end

  def visited_dir( parentNode, childNode )
    parentNode.add_child( childNode )
  end


end
