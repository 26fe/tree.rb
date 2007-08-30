# common
require 'common/dirtreewalker'
require 'common/builddirtreevisitor'

require 'common/gui_fox/utility'
require 'common/gui_fox/gui_dir_tree_visitor'

class TreeNodeViewer  < FXMainWindow
  
  def initialize(app)
    # Do base class initialize first
    super(app, "Splitter Test", :opts => DECOR_ALL, :width => 800, :height => 600)

    # Construct some icons we'll use
    @folder_open   = Utility.makeIcon(getApp(), "minifolderopen.png")
    @folder_closed = Utility.makeIcon(getApp(), "minifolder.png")
    @doc           = Utility.makeIcon(getApp(), "minidoc.png")

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
    visitor = GuiDirTreeVisitor.new( @guitree, @folder_open, @folder_closed, @doc )
    dtw.run( visitor )
  end
   
#  def makeTree( tree )
#      topmost = tree.appendItem(nil, "Top", @folder_open, @folder_closed)
#    tree.expandTree(topmost)
#      tree.appendItem(topmost, "First", @doc, @doc)
#      tree.appendItem(topmost, "Second", @doc, @doc)
#      tree.appendItem(topmost, "Third", @doc, @doc)
#      branch = tree.appendItem(topmost, "Fourth", @folder_open, @folder_closed)
#      tree.expandTree(branch)
#        tree.appendItem(branch, "Fourth-First", @doc, @doc)
#        tree.appendItem(branch, "Fourth-Second", @doc, @doc)
#        twig = tree.appendItem(branch, "Fourth-Third",
#                                @folder_open, @folder_closed)
#          tree.appendItem(twig, "Fourth-Third-First", @doc, @doc)
#          tree.appendItem(twig, "Fourth-Third-Second", @doc, @doc)
#          tree.appendItem(twig, "Fourth-Third-Third", @doc, @doc)
#          leaf = tree.appendItem(twig, "Fourth-Third-Fourth",
#                                  @folder_open, @folder_closed)
#          leaf.setEnabled(false)
#            tree.appendItem(leaf, "Fourth-Third-Fourth-First", @doc, @doc)
#            tree.appendItem(leaf, "Fourth-Third-Fourth-Second", @doc, @doc)
#            tree.appendItem(leaf, "Fourth-Third-Fourth-Third", @doc, @doc)
#        twig = tree.appendItem(branch, "Fourth-Fourth",
#                                @folder_open, @folder_closed)
#          tree.appendItem(twig, "Fourth-Fourth-First", @doc, @doc)
#          tree.appendItem(twig, "Fourth-Fourth-Second", @doc, @doc)
#          tree.appendItem(twig, "Fourth-Fourth-Third", @doc, @doc)
#          0.upto(9) { |i| tree.appendItem(twig, i.to_s, @doc, @doc) }
#        twig = tree.appendItem(branch, "Fourth-Fifth",
#                                @folder_open, @folder_closed)
#        tree.expandTree(twig)
#          tree.appendItem(twig, "Fourth-Fifth-First", @doc, @doc)
#          tree.appendItem(twig, "Fourth-Fifth-Second", @doc, @doc)
#          tree.appendItem(twig, "Fourth-Fifth-Third", @doc, @doc)
#          0.upto(9) { |i| tree.appendItem(twig, i.to_s, @doc, @doc) }
#      tree.appendItem(topmost, "Fifth", @doc, @doc)
#      tree.appendItem(topmost, "Sixth", @doc, @doc)
#      branch = tree.appendItem(topmost, "Seventh", @folder_open, @folder_closed)
#        tree.appendItem(branch, "Seventh-First", @doc, @doc)
#        tree.appendItem(branch, "Seventh-Second", @doc, @doc)
#        tree.appendItem(branch, "Seventh-Third", @doc, @doc)
#      tree.appendItem(topmost, "Eighth", @doc, @doc)
#
#  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end