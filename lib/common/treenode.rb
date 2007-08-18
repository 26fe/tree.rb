
require 'common/leafnode'

class TreeNode < LeafNode

  def initialize( parent, name )
    super( parent, name )
    # @parent = parent
    # @name = name
    # @path = nil
    @leaves = []
    @treeNodes = []
  end

  def add_leaf( leaf )
    @leaves << leaf
  end

  def add_child( treeNode )
    @treeNodes << treeNode
  end

  def convert( depth = 0 )

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
        str << " |  " + v
        str << "\n"
      }
    end

    @treeNodes.each { |tn|
      str << tn.convert( depth + 1 )
    }
    str
  end
end
