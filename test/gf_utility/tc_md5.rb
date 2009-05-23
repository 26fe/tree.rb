# stdlib
require 'test/unit'

$TREE_VISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", "..") )
$:.unshift( File.join($TREE_VISITOR_HOME, "lib" ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "test" ) )
$TEST_FILE = File.join( $TREE_VISITOR_HOME, "lib", "tree_visitor.rb" )

require 'gf_utility/md5.rb'

class TCMD5 < Test::Unit::TestCase

  def test_simple_build
    file_name = File.join( $TEST_FILE )
    MD5.file( file_name )
  end

end
