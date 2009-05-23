#!/usr/bin/env ruby
#
# Piccolo wrapper per richiamare il programma
# clidirtree
#

$TREE_VISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($TREE_VISITOR_HOME, "lib" ) )

require "tree_visitor/cli/cli_dir_tree"

CliDirTree.run
exit
