#!/usr/bin/env ruby
#
# Piccolo wrapper per richiamare il programma
# clidirtree
#

$TREEVISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($TREEVISITOR_HOME, "lib" ) )

require "treevisitor/cli/cli_dir_tree"

CliDirTree.run
exit
