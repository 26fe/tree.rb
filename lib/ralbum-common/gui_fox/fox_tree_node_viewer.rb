# common
require 'common/dir_tree_walker'
require 'common/build_dir_tree_visitor'

require 'common/gui_fox/fox_utility'
require 'common/gui_fox/fox_dir_tree_visitor'

class FoxTreeNodeViewer  < FXMainWindow
  
  def initialize(app)
    # Do base class initialize first
    super(app, "Splitter Test", :opts => DECOR_ALL, :width => 800, :height => 600)

    # Construct some icons we'll use
    @folder_open   = FoxUtility.makeIcon(getApp(), "minifolderopen.png")
    @folder_closed = FoxUtility.makeIcon(getApp(), "minifolder.png")
    @doc           = FoxUtility.makeIcon(getApp(), "minidoc.png")

    makeMenu()
    # Main window interior
    @splitter = FXSplitter.new(self, (LAYOUT_SIDE_TOP|LAYOUT_FILL_X|
      LAYOUT_FILL_Y|SPLITTER_REVERSED|SPLITTER_TRACKING))
    group1 = FXVerticalFrame.new(@splitter,
      FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y, :padding => 0)
    group2 = FXVerticalFrame.new(@splitter,
      FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y)
      
    @guitree = FXTreeList.new(group1,
      :opts => (LAYOUT_FILL_X|LAYOUT_FILL_Y|LAYOUT_TOP|LAYOUT_RIGHT|TREELIST_SHOWS_LINES|
      TREELIST_SHOWS_BOXES|TREELIST_ROOT_BOXES|TREELIST_EXTENDEDSELECT))
    # makeTree( @guitree )
    makeInfoPanel(group2)
    makeTree( "." )
    
    # Make a tool tip
    FXToolTip.new(getApp(), 0)
  end
  
  def makeMenu()
    menubar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    filemenu = FXMenuPane.new(self)
    FXMenuCommand.new(filemenu, "Open directory dialog", @folder_open).connect(SEL_COMMAND) {
      dirDialog = FXDirDialog.new(self, "Choose a directory")
      if dirDialog.execute != 0
        dirname = dirDialog.directory
        makeTree( dirname )
        # FXMessageBox.information(self, MBOX_OK, "Selected Directory", dirname)
      end
    }
    
    FXMenuCommand.new(filemenu, "&Quit\tCtl-Q", nil, getApp(), FXApp::ID_QUIT)
    FXMenuTitle.new(menubar, "&File", nil, filemenu)
    helpmenu = FXMenuPane.new(self)
    FXMenuCommand.new(helpmenu, "&About FOX...").connect(SEL_COMMAND) {
      FXMessageBox.information(self, MBOX_OK,
        "About FOX:- An intentionally long title",
        "FOX is a really, really cool C++ library!\nExample written by Jeroen")
    }
    FXMenuTitle.new(menubar, "&Help", nil, helpmenu, LAYOUT_RIGHT)
  end
  
  def makeInfoPanel( group )
    FXLabel.new(group, "Matrix", nil, LAYOUT_CENTER_X)
    FXHorizontalSeparator.new(group, SEPARATOR_GROOVE|LAYOUT_FILL_X)
    matrix = FXMatrix.new(group, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)
    
    FXLabel.new(matrix, "Alpha:", nil,
      JUSTIFY_RIGHT|LAYOUT_FILL_X|LAYOUT_CENTER_Y)
    FXTextField.new(matrix, 2, nil, 0, (FRAME_SUNKEN|FRAME_THICK|
      LAYOUT_FILL_X|LAYOUT_CENTER_Y|LAYOUT_FILL_COLUMN))
    FXLabel.new(matrix, "Beta:", nil,
      JUSTIFY_RIGHT|LAYOUT_FILL_X|LAYOUT_CENTER_Y)
    FXTextField.new(matrix, 2, nil, 0, (FRAME_SUNKEN|FRAME_THICK|
      LAYOUT_FILL_X|LAYOUT_CENTER_Y|LAYOUT_FILL_COLUMN))
    FXLabel.new(matrix, "Gamma:", nil,
      JUSTIFY_RIGHT|LAYOUT_FILL_X|LAYOUT_CENTER_Y)
    FXTextField.new(matrix, 2, nil, 0, (FRAME_SUNKEN|FRAME_THICK|
      LAYOUT_FILL_X|LAYOUT_CENTER_Y|LAYOUT_FILL_COLUMN))
    end

  def makeTree( dirname )
    dirname = File.expand_path( dirname )
    
    puts "reading : #{dirname}"
  
    dtw = DirTreeWalker.new( dirname )
    dtw.add_ignore_dir( ".svn" )
    dtw.add_ignore_dir( "catalog_data" )
    visitor = FoxDirTreeVisitor.new( @guitree, @folder_open, @folder_closed, @doc )
    dtw.run( visitor )
  end
   
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end