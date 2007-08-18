
require 'common/leafnode'

class TreeNode < LeafNode

  def initialize( parent, name )
    super( parent, name )
    # @parent = parent
    # @name = name
    # @path = nil
    @items = []
    @treeNodes = []
  end

  def add_item( item )
    @items << item
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

    if ! @items.empty?
      @items.each{ |v|
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
