#!/usr/bin/env ruby

#
# File per testare i widget wx
#

# rubygems
require 'rubygems'
require 'wx'

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require 'common/gui_wx/wx_test_my_list_ctrl_app'
require 'common/gui_wx/wx_my_list_ctrl'


# LC_LIST
# LC_REPORT
# LC_ICON
# LC_SMALL_ICON

StyleMenuLCList,
StyleMenuLCReport,
StyleMenuLCIcon,
StyleMenuLCSmallIcon = 101,102,103,104

a = WXTestListCtrlApp.new
a.main_loop()
