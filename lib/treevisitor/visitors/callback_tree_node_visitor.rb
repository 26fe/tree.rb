#
# Executes a block when enter in a node
# The block are defined from on_enter_X methods
# The blocks take as argument only the node
#
class CallbackTreeNodeVisitor < TreeNodeVisitor

  def initialize
    super()
    @stack = []
    @root = nil
    @action_enter_tree_node = nil
    @action_visit_leaf_node = nil
  end

  def on_enter_tree_node( &action )
    @action_enter_tree_node = action
  end

  def on_visit_leaf_node( &action )
    @action_visit_leaf_node = action
  end

  def enter_tree_node( tree_node )
    # parent_node = @stack.empty? ? nil : @stack.last
    @root = tree_node if @stack.empty?
    @stack.push( tree_node )
    @action_enter_tree_node.call( tree_node ) if @action_enter_tree_node
  end

  def exit_tree_node( tree_node )
    @stack.pop
  end

  def visit_leaf_node( leaf_node )
    # parent_node = @stack.last
    @action_visit_leaf_node.call( leaf_node ) if @action_visit_leaf_node
  end

end
