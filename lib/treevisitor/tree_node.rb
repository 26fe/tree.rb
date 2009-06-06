require 'treevisitor/leaf_node'

#
# TreeNode can contains other TreeNode (children)
# and can contains LeafNode (leves)
#
# TreeNode @childs -1---n-> TreeNode
#          @leaves -1---n-> LeafNode
#
class TreeNode < AbsNode
  
  attr_reader :leaves
  attr_reader :children

  def initialize( name, parent = nil )
    @leaves = []
    @children = []
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
  # invalidate propagates form parent to children and leaves
  #
  def invalidate
    super
    @children.each{ |c| c.invalidate }
    @leaves.each{ |l| l.invalidate }
  end
  
  def nr_nodes
    nr = @leaves.length + @children.length
    @children.inject( nr ) { |nr,c| nr + c.nr_nodes }
  end
  
  def nr_leaves
    @leaves.length + @children.inject(0) { |sum, child| sum + child.nr_leaves }
  end

  def nr_children
    @children.length + @children.inject(0) { |sum, child| sum + child.nr_children }
  end
        
  def add_leaf( leaf )
    return if leaf.parent == self
    if not leaf.parent.nil?
      leaf.remove_from_parent
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
    @children << treeNode
  end
  
  def find( name )
    return self if self.name == name
    
    leaf = @leaves.find { |l| l.name == name }
    if leaf
      return leaf
    end
    
    @children.each {|c|
      node = c.find(name)
      return node if node
    }
    nil
  end

  #
  # return the visitor
  #
  def accept( visitor )
    visitor.enter_tree_node( self )
    @leaves.each{ |leaf|
      leaf.accept( visitor )
    }
    @children.each { |child|
      child.accept( visitor )
    }
    visitor.exit_tree_node( self )
    visitor
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
        if @children.empty?
          str << " |    "
        else
          str << " |  | "
        end
        str << l.to_str
        str << "\n"
      }
    end

    @children.each { |tn|
      str << tn.to_str( depth + 1 )
    }
    str
  end
end
