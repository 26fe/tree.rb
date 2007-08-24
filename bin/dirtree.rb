#
# Piccolo wrapper per richiamare il programma
# clidirtree
#

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require "common/cli/cli_dirtree"

CliDirTree.run
exit


