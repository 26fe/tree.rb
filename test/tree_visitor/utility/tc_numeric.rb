# stdlib
require 'test/unit'

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", "..", ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )
$:.unshift( File.join($COMMON_HOME, "test" ) )
$TEST_FILE = File.join( $COMMON_HOME, "lib", "tree_visitor.rb" )


require 'tree_visitor/utility/numeric.rb'

class TCNumeric < Test::Unit::TestCase

  def test_simple
    assert_equal "10", 10.with_separator
    assert_equal "10.0", 10.0.with_separator
    assert_equal "1,000,000", 1000000.with_separator
  end

end
