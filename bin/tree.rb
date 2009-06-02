#!/usr/bin/env ruby
#
# Wrapper for the class CliTree

$TREEVISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($TREEVISITOR_HOME, "lib" ) )

require "treevisitor/cli/cli_tree"
exit CliTree.run
