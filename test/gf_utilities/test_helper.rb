require 'test/unit'

$TREEVISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )
$:.unshift( File.join($TREEVISITOR_HOME, "lib" ) )
$:.unshift( File.join($TREEVISITOR_HOME, "test" ) )
