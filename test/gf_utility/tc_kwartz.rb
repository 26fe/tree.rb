require 'test/unit'

$TREE_VISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "lib" ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "test" ) )

require 'gf_utility/kwartzhelper'

class TCDirProcessor < Test::Unit::TestCase

  KWARTZ_TEST_DATA = File.join( $TREE_VISITOR_HOME, "test_data", "gf_utility", "kwartz_test_data" )

  def test_simple
    template_dir     = File.join( KWARTZ_TEST_DATA, "source" )
    template_out     = File.join( KWARTZ_TEST_DATA, "out" )
    kwartz_compile( template_dir, nil, template_out )
  end

end