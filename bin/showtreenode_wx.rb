# rubygems
require 'rubygems'
require 'wx'

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require 'common/gui_wx/wx_tree_ctrl'
require 'common/gui_wx/wx_tree_node_viewer_frame'
require 'common/gui_wx/wx_tree_node_viewer_app'

a = WxTreeNodeViewerApp.new
a.main_loop()
