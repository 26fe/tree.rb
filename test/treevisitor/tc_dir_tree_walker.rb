require File.join(File.dirname(__FILE__), "test_helper")


class TCDirTreeWalker < Test::Unit::TestCase

  TEST_DIRECTORY = File.join( TREEVISITOR_HOME, "test_data", "tree_visitor", "test_data" )

  def test_simple  
    dir_tree_walker = DirTreeWalker.new( TEST_DIRECTORY )
    dir_tree_walker.ignore_dir( ".svn" )

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename( pathname ) }
    dir_tree_walker.run( visitor )
    assert_equal( 9, accumulator.length )
    assert_equal( %w{ test_data dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 .dir_with_dot dummy.txt}.sort, accumulator.sort )
  end

  def test_ignore_function
    dtp = DirTreeWalker.new( "." )

    dtp.ignore(/^\./)
    assert dtp.ignore_file?( ".thumbnails" )
    assert dtp.ignore_dir?( ".thumbnails" )

    dtp.ignore_dir("thumbnails")

    assert dtp.ignore_dir?( ".thumbnails" ) 
    assert dtp.ignore_dir?( "thumbnails" )
    assert ! dtp.ignore_dir?( "pippo" )


    dtp.ignore_file("xvpics")

    assert( dtp.ignore_file?( "xvpics" ) )
  end

end
