require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/dir_tree_walker.rb'
require 'treevisitor/tree_node_visitor.rb'

class TCDirTreeWalker < Test::Unit::TestCase

  TEST_DIRECTORY = File.join( $TREEVISITOR_HOME, "test_data", "tree_visitor", "test_data" )

  def test_simple  
    dir_tree_walker = DirTreeWalker.new( TEST_DIRECTORY )
    dir_tree_walker.add_ignore_dir( ".svn" )

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename( pathname ) }
    dir_tree_walker.run( visitor )
    assert_equal( 9, accumulator.length )
    assert_equal( %w{ test_data dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 .dir_with_dot dummy.txt}, accumulator )
  end

  def test_ignore_function
    dtp = DirTreeWalker.new( "." )

    dtp.add_ignore_pattern(/^\./)
    assert dtp.ignore_file?( ".thumbnails" )
    assert dtp.ignore_dir?( ".thumbnails" )

    dtp.add_ignore_dir("thumbnails")

    assert dtp.ignore_dir?( ".thumbnails" ) 
    assert dtp.ignore_dir?( "thumbnails" )
    assert ! dtp.ignore_dir?( "pippo" )


    dtp.add_ignore_file("xvpics")

    assert( dtp.ignore_file?( "xvpics" ) )
  end

end
