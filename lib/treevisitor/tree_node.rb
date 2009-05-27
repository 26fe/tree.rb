# common
require 'treevisitor/leaf_node'

#
# Un treeNode e' come un AbsNode
# in piu' ha la possibilita' di contenere
# altri treeNode e LeafNode
#
# TreeNode @childs -1---n-> TreeNode
#          @leaves -1---n-> LeafNode
#
class TreeNode < AbsNode
  
  attr_reader :leaves
  attr_reader :childs

  def initialize( name, parent = nil )
    @leaves = []
    @childs = []
    super( name )
    if parent
      parent.add_child( self )
    end
  end

  def root?
    @parent.nil?
  end
  
  #
  # invalidate cached info
  #
  def invalidate
    super
    @childs.each{ |c| c.invalidate }
    @leaves.each{ |l| l.invalidate }
  end
  
  def nr_nodes
    nr = @leaves.length + @childs.length
    @childs.inject( nr ) { |nr,c| nr + c.nr_nodes }
  end
  
  def nr_leaves
    @leaves.length + @childs.inject(0) { |sum, child| sum + child.nr_leaves }
  end

  def nr_childs
    @childs.length + @childs.inject(0) { |sum, child| sum + child.nr_childs }
  end
        
  def add_leaf( leaf )
    return if leaf.parent == self
    if not leaf.parent.nil?
      leaf.remove_from_parent()
    end  
    leaf.parent = self
    if @leaves.length > 0
      @leaves.last.next = leaf
      leaf.prev = @leaves.last
      leaf.next = nil
    end
    leaf.invalidate
    @leaves << leaf
  end

  def add_child( treeNode )
    return if treeNode.parent == self
    if not treeNode.parent.nil?
      treeNode.remove_from_parent()
    end  
    treeNode.invalidate
    treeNode.parent = self
    @childs << treeNode
  end
  
  def find( name )
    if self.name == name
      return self
    end
    
    leaf = @leaves.find { |l| l.name == name }
    if leaf
      return leaf
    end
    
    @childs.each {|c| 
      node = c.find(name)
      return node if node
    }
    nil
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
