require 'treevisitor/leaf_node'

#
# TreeNode can contains other TreeNode (children)
# and can contains LeafNode (leves)
#
# TreeNode @childs -1---n-> TreeNode
#          @leaves -1---n-> LeafNode
#
class TreeNode < AbsNode
  
  class << self
    
    def create(class1 = TreeNode, class2 = LeafNode, &block)
      if class1.ancestors.include?(TreeNode) and class2.ancestors.include?(LeafNode)
        @tree_node_class = class1
        @leaf_node_class = class2
      elsif class1.ancestors.include?(LeafNode) and class2 == LeafNode
        @tree_node_class = self
        @leaf_node_class = class1
      end

      if @tree_node_class.nil? || @leaf_node_class.nil?
        raise "Must be specified class derived from TreeNode and LeafNode"
      end

      @scope_stack = []
      class_eval(&block)
    end

    private

    def node(name, &block)
      parent_node = @scope_stack.length > 0 ? @scope_stack[-1] : nil
      tree_node = @tree_node_class.new(name, parent_node)
      @scope_stack.push tree_node
      class_eval(&block)
      @scope_stack.pop
    end

    def leaf(name)
      tree_node = @scope_stack[-1]
      @leaf_node_class.new(name, tree_node)
    end
  end

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
    else
      leaf.prev = nil
    end
    leaf.next = nil
    leaf.invalidate
    @leaves << leaf
  end

  def add_child( tree_node )
    return if tree_node.parent == self
    if not tree_node.parent.nil?
      tree_node.remove_from_parent
    else
      tree_node.prefix_path = nil
    end  
    tree_node.invalidate
    tree_node.parent = self
    if @children.length > 0
      @children.last.next = tree_node
      tree_node.prev = @children.last
    else
      tree_node.prev = nil
    end
    tree_node.next = nil
    @children << tree_node
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

  def to_str( prefix= "" )
    str = ""

    if root?
      str << to_s << "\n"
    else
      str << prefix 
      if self.next 
        str << "|-- "
      else
        str << "\`-- "
      end
      str << to_s << "\n"
      prefix += self.next ? "|   " : "    "
    end
    
    @leaves.each do |leaf|
      str << prefix
      if !leaf.next.nil? or !@children.empty?
        str << "|-- "
      else
        str << "\`-- "
      end
      str <<  leaf.to_s << "\n"
    end

    @children.each do |child|
      str << child.to_str( prefix )
    end
    str
  end

end
