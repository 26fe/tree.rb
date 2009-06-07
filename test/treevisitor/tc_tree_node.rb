require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/tree_node.rb'

class TCTreeNode < Test::Unit::TestCase

  def test_new
    ta = TreeNode.new( "a" )
    assert( ta.root? )

    ln1 = LeafNode.new("1", ta)
    assert_equal( ta, ln1.parent )
    assert !ln1.root?

    ln2 = LeafNode.new("2", ta)
    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )
    assert_equal( tb, ln3.parent )
    
    # test depth
    assert_equal( 2, tb.depth )
    assert_equal( 3, ln3.depth )
    
    # test nr_nodes
    assert_equal( 1, tb.nr_nodes )
    assert_equal( 4, ta.nr_nodes )

    # puts ta.to_str
  end

  def test_add_child_and_add_leaf
    ta = TreeNode.new( "a" )
    assert( ta.root? )
    
    ln1 = LeafNode.new("1")
    ta.add_leaf( ln1 )
    assert_equal( ta, ln1.parent )

    ln2 = LeafNode.new("2", ta)
    ta.add_leaf( ln2 )

    tb = TreeNode.new( "b", ta )
    ln3 = LeafNode.new( "3", tb )
    tb.add_leaf( ln3 )
    assert_equal( tb, ln3.parent )

    ta.add_child( tb )
    # puts ta.to_str
  end
  
  def test_next_and_prev
    ta = TreeNode.new( "a" )
    assert_nil ta.prev
    assert_nil ta.next
    
    ln1 = LeafNode.new("1", ta)
    assert_nil ln1.prev
    assert_nil ln1.next
    
    ln2 = LeafNode.new("2", ta)
    assert_equal ln1, ln2.prev 
    assert_nil ln2.next 
    
    ln3 = LeafNode.new("3", ta)
    assert_equal ln3, ln2.next

    tb = TreeNode.new("b", ta)
    assert_nil tb.next
    assert_nil tb.prev

    tc = TreeNode.new("c", ta)
    assert_equal tb, tc.prev
    assert_nil tc.next
  end
  
  def test_nr_nodes_and_nr_leaves_adn_nr_children
    ta = TreeNode.new( "a" )
      ln1 = LeafNode.new("1", ta)
      ln2 = LeafNode.new("2", ta)
      tb = TreeNode.new( "b", ta )
        ln3 = LeafNode.new( "3", tb )
    
    assert_equal( 4, ta.nr_nodes )
    assert_equal( 3, ta.nr_leaves )
    assert_equal( 1, ta.nr_children )
    
    assert_equal( 1, tb.nr_nodes )
    assert_equal( 1, tb.nr_leaves )
    assert_equal( 0, tb.nr_children )
  end
  
  def test_prefix_path
    ta = TreeNode.new( "a" )
      ln1 = LeafNode.new("1", ta)
      ln2 = LeafNode.new("2", ta)
      tb = TreeNode.new( "b", ta )
        ln3 = LeafNode.new( "3", tb )

    assert_equal( "a",   ta.path )
    assert_equal( "a/b", tb.path )
    assert_equal( "a",   ta.path_with_prefix  )
    assert_equal( "a/b", tb.path_with_prefix )
    
    ta.prefix_path= "<root>/"

    assert_equal("<root>/", ta.prefix_path )
    assert_equal( "a",   ta.path )
    assert_equal( "a/b", tb.path )
    assert_equal( "<root>/a",   ta.path_with_prefix  )
    assert_equal( "<root>/a/b", tb.path_with_prefix )
  end

  def test_invalidate
    ta = TreeNode.new( "a" )
      ln1 = LeafNode.new("1", ta)
      ln2 = LeafNode.new("2", ta)
      tb = TreeNode.new( "b", ta )
        ln3 = LeafNode.new( "3", tb )

    ta.prefix_path="root/"
    assert_equal( "a/b", tb.path )
    assert_equal( "root/a/b",  tb.path_with_prefix )
    assert_equal( 2, tb.depth )
    
    r = TreeNode.new( "r" )
    r.add_child( ta )
    assert_equal( "r/a/b", tb.path )
    assert_equal( "r/a/b", tb.path_with_prefix )

    r.prefix_path="new_root/"
    assert_equal( "r/a/b", tb.path )
    assert_equal( "new_root/r/a/b", tb.path_with_prefix )
    assert_equal( 3, tb.depth )
  end
  
  def test_find
    ta = TreeNode.new( "a" )
      ln1 = LeafNode.new("1", ta)
      ln2 = LeafNode.new("2", ta)
      tb = TreeNode.new( "b", ta )
        ln3 = LeafNode.new( "3", tb )

    assert_equal(ln3, ta.find( "3"))
    assert_equal(tb, ta.find( "b"))
    assert_nil( ta.find("not existent"))
  end

  def test_to_str
    ta = TreeNode.new( "a" )
      ln1 = LeafNode.new("1", ta)
      ln2 = LeafNode.new("2", ta)
      tb = TreeNode.new( "b", ta )
        ln3 = LeafNode.new( "3", tb )

    out = <<EOS
a
|-- 1
|-- 2
`-- b
    `-- 3
EOS
    assert_equal out, ta.to_str
  end

end
