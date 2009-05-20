require 'test/unit'

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )

$TEST_DATA = File.join( $COMMON_HOME, "test", "tree_visitor", "test_data" )

require 'tree_visitor/dir_processor'

class TCDirProcessor < Test::Unit::TestCase
  def test_simple
    dp = DirProcessor.new($TEST_DATA) { |f| puts f }
    dp.run
  end
end
