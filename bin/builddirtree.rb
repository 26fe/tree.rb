
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require "common/cli/cli_dirtree"

CliDirTree.run
exit

#puts TreeNode.new( "a" ).convert( 0 )
#puts TreeNode.new( "a" ).convert( 1 )
#
#ta = TreeNode.new( "a" )
#ta.add_value( "1" )
#ta.add_value( "2" )
#
#tb = TreeNode.new( "b" )
#tb.add_value( "3" )
#
#ta.add_child( tb )
#puts ta.convert



dtp = PrintDirTree.new( "." )
dtp.add_ignore_dir( ".svn" )
treeNode = dtp.run

puts "---------------------------------"

puts treeNode.convert()
exit
