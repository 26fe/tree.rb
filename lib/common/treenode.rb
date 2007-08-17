
class TreeNode

  attr_reader :parent

  def initialize( parent, name )
    @parent = parent
    @name = name
    @values = []
    @treeNodes = []
  end

  def add_value( value )
    @values << value
  end

  def add_child( treeNode )
    @treeNodes << treeNode
  end

  def convert( depth = 0 )

    str = ""
    (0..depth).step(1) {
      str << " |-"
    }

    str << @name
    str << "\n"

    if ! @values.empty?
      @values.each{ |v|
        (0..depth).step(1) {
          str << " |-"
        }
        str << "  " + v
        str << "\n"
      }
    end

    str << "\n"

    @treeNodes.each { |tn|
      str << tn.convert( depth + 1 )
    }
    str
  end
end
