require 'common/treenode'
require 'common/dirtree_processor'

#
# Utilizzo della classa astratta DirTreeProcessor
# per costruire un albero di oggetti
#
class BuildDirTreeProcessor < DirTreeProcessor

  def initialize( *args )
    super( *args )
  end

  protected

  def visit_file( treeNode, pathname )
    basename = File.basename( pathname )
    LeafNode.new( treeNode, basename )
  end

  def visited_file( treeNode, nodeItem )
    treeNode.add_leaf( nodeItem )
  end

  def visit_dir( parentNode, dirname )
    if ! parentNode.nil?
      dirname = File.basename( dirname )
    end
    TreeNode.new( parentNode, dirname )
  end

  def visited_dir( parentNode, childNode )
    parentNode.add_child( childNode )
  end


end
