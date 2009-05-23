# stdlib
require "test/unit"

# common
$TREE_VISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..") )
$:.unshift( File.join($TREE_VISITOR_HOME, "lib" ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "test" ) )

require "tree_visitor"

require "utility/tc_md5"

require "tree_visitor/tc_dir_processor"
require "tree_visitor/tc_dir_tree_walker"
require "tree_visitor/tc_tree_node"
require "tree_visitor/tc_tree_node_visitor"
