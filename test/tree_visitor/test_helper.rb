$TREE_VISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )

lib_dir  = File.join($TREE_VISITOR_HOME, "lib" )
test_dir = File.join($TREE_VISITOR_HOME, "test" )
$:.unshift lib_dir  unless $:.include?(lib_dir)
$:.unshift test_dir unless $:.include?(test_dir)

$TEST_DATA = File.join( $TREE_VISITOR_HOME, "test_data", "tree_visitor", "test_data" )

require 'test/unit'