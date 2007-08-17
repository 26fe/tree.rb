
class TreeNode

  def initialize( name)
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
    str = (" " * depth) + @name + " -"
    @values.each{ |v|
      str << " " + v
    }
    str << "\n"
    @treeNodes.each { |tn|
      str << tn.convert( depth + 1 )
    }
    str
  end
end
