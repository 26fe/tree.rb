# rubygems
require 'rubygems'
require 'wx'

# common
$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require 'common/gui_wx/my_tree_ctrl'
require 'common/gui_wx/my_frame'

TreeTest_Ctrl = 1000

TreeCtrlIcon_File,
TreeCtrlIcon_FileSelected,
TreeCtrlIcon_Folder,
TreeCtrlIcon_FolderSelected,
TreeCtrlIcon_FolderOpened = 0,1,2,3,4

class MyApp < Wx::App
  def initialize
    super
  end
  
  def on_init
    # Create the main frame window
    frame = MyFrame.new("TreeCtrl Test", 50, 50, 450, 600)

    # show the frame
    frame.show(true)
  end
end


a = MyApp.new
a.main_loop()
