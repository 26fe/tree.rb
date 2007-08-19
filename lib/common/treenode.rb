# common
require 'common/leafnode'

#
# Un treeNode e' come un LeafNode
# in piu' ha la possibilita' di contenere
# altri treeNode e LeafNode
#
class TreeNode < AbsNode

  def initialize( parent, name )
    super( name )
    if parent
      parent.add_child( self )
    end
    @leaves = []
    @treeNodes = []
  end

  def root?
    @parent.nil?
  end

  def add_leaf( leaf )
    return if leaf.parent == self
    leaf.parent = self
    @leaves << leaf
  end

  def add_child( treeNode )
    return if treeNode.parent == self
    treeNode.parent = self
    @treeNodes << treeNode
  end

  def accept( visitor )

    visitor.visit_treeNode( self )
    @leaves.each{ |l|
      l.accept( visitor )
    }
    @treeNodes.each { |tn|
      tn.accept( visitor )
    }
  end

  def to_s( depth = 0 )

    str = ""
    (0...depth).step {
      str << " |-"
    }

    str << @name
    str << "\n"

    if ! @leaves.empty?
      @leaves.each{ |v|
        (0...depth-1).step {
          str << " |-"
        }
        if @treeNodes.empty?
          str << " |    "
        else
          str << " |  | "
        end
        str << v
        str << "\n"
      }
    end

    @treeNodes.each { |tn|
      str << tn.to_s( depth + 1 )
    }
    str
  end
end
