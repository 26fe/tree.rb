require File.join(File.dirname(__FILE__), "test_helper")

require 'tree_visitor/dir_tree_walker.rb'
require 'tree_visitor/tree_node_visitor.rb'

class TCDirTreeWalker < Test::Unit::TestCase

  def test_simple  
    dir_tree_walker = DirTreeWalker.new( $TEST_DATA )
    dir_tree_walker.add_ignore_dir( ".svn" )

    accumulator = []
    visitor = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename( pathname ) }
    dir_tree_walker.run( visitor )
    assert_equal( 7, accumulator.length )
    assert_equal( %w{ test_data dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 }, accumulator )
  end

  def test_ignore_dir
    dtp = DirTreeWalker.new( "." )

    dtp.add_ignore_dir(".xvpics")
    dtp.add_ignore_dir(".thumbnails")
    dtp.add_ignore_dir("catalog_data")

    assert( dtp.ignore_dir?( ".thumbnails" ) )
    assert( ! dtp.ignore_dir?( "pippo" ) )
  end

end
