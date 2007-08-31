# common
require 'common/leaf_node'

#
# Un treeNode e' come un AbsNode
# in piu' ha la possibilita' di contenere
# altri treeNode e LeafNode
#
# TreeNode @childs -1---n-> TreeNode
#          @leaves -1---n-> LeafNode
#
class TreeNode < AbsNode

  def initialize( name, parent = nil )
    super( name )
    if parent
      parent.add_child( self )
    end
    @leaves = []
    @childs = []
  end

  def root?
    @parent.nil?
  end
  
  def nr_nodes
    nr = @leaves.length + @childs.length
    @childs.inject( nr ) { |nr,c| nr + c.nr_nodes }
  end
  
  def add_leaf( leaf )
    return if leaf.parent == self
    if not leaf.parent.nil?
      leaf.remove_from_parent()
    end  
    leaf.parent = self
    @leaves << leaf
  end

  def add_child( treeNode )
    return if treeNode.parent == self
    if not treeNode.parent.nil?
      treeNode.remove_from_parent()
    end  
    treeNode.parent = self
    @childs << treeNode
  end

  def accept( visitor )
    visitor.enter_treeNode( self )
    @leaves.each{ |l|
      l.accept( visitor )
    }
    @childs.each { |tn|
      tn.accept( visitor )
    }
    visitor.exit_treeNode( self )
  end

  def to_str( depth = 0 )
    str = ""
    (0...depth).step {
      str << " |-"
    }

    str << @name
    str << "\n"

    if ! @leaves.empty?
      @leaves.each{ |l|
        (0...depth-1).step {
          str << " |-"
        }
        if @childs.empty?
          str << " |    "
        else
          str << " |  | "
        end
        str << l.to_str
        str << "\n"
      }
    end

    @childs.each { |tn|
      str << tn.to_str( depth + 1 )
    }
    str
  end
end
