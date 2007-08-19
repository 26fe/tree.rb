require 'test/unit'

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )

require 'common/treenode.rb'
require 'common/treenodevisitor.rb'

class TestTreeNodeVisitor < Test::Unit::TestCase

  def test_simple

    #puts TreeNode.new( "a" ).convert( 0 )
    #puts TreeNode.new( "a" ).convert( 1 )
    #
    ta = TreeNode.new( nil, "a" )
    ta.add_leaf( LeafNode.new(ta, "1") )
    ta.add_leaf( LeafNode.new(ta, "2") )
    #
    tb = TreeNode.new( ta, "b" )
    tb.add_leaf( LeafNode.new( tb, "3" ) )

    ta.add_child( tb )
    # puts ta.to_s

    visitor = PrintTreeNodeVisitor.new
    ta.accept( visitor )

  end


end
