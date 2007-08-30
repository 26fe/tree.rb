#!/usr/bin/env ruby

# rubygems
require 'rubygems'
require 'fox16'
include Fox

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require 'common/gui_fox/tree_node_viewer'

application = FXApp.new("Splitter", "FoxTest")
TreeNodeViewer.new(application)
application.create
application.run
