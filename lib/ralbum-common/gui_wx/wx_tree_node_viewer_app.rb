
class WxTreeNodeViewerApp < Wx::App

  def initialize
    super
  end
  
  def on_init
    # Create the main frame window
    buildFrame

    # show the frame
    @frame.show(true)
  end
  
  # private
  
  def buildFrame
    @frame = Wx::Frame.new(nil, -1, "Tree Node Viewer", Wx::Point.new(50, 50), Wx::Size.new(450, 600))

    # This reduces flicker effects - even better would be to define
    # OnEraseBackground to do nothing. When the tree control's scrollbars are
    # show or hidden, the frame is sent a background erase event.
    @frame.set_background_colour(Wx::Colour.new(255, 255, 255))
    
    
    makeMenubar( @frame )
    
    splitterHor = Wx::SplitterWindow.new(@frame, -1)
    
      splitterVer = Wx::SplitterWindow.new(splitterHor, -1) 
        @treeCtrl = createTreeCtrl( splitterVer )
        @infoCtrl = creteInfoCtrl( splitterVer)
      splitterVer.set_minimum_pane_size(20)
      splitterVer.split_vertically(@treeCtrl, @infoCtrl, -100)
    
      @logCtrl = createLogCtrl( splitterHor )
    splitterHor.set_minimum_pane_size(20)
    splitterHor.split_horizontally(splitterVer, @logCtrl, -50)

  end

  def makeMenubar( frame )
    file_menu  = Wx::Menu.new

    file_menu.append(DIALOGS_DIR_CHOOSE,  "&Choose a directory\tCtrl-D")
    file_menu.append(Wx::ID_ABOUT, "&About...")
    file_menu.append_separator()
    file_menu.append(Wx::ID_EXIT, "E&xit\tAlt-X")

    menu_bar = Wx::MenuBar.new
    menu_bar.append(file_menu, "&File")
    frame.set_menu_bar(menu_bar)

    evt_menu(Wx::ID_EXIT) {|event| on_quit(event) }
    evt_menu(Wx::ID_ABOUT) {|event| on_about(event) }
    evt_menu(DIALOGS_DIR_CHOOSE) {|event| on_dir_choose(event) }
  end

  def createTreeCtrl( parent )
    style = Wx::TR_DEFAULT_STYLE|Wx::TR_EDIT_LABELS|
            Wx::TR_TWIST_BUTTONS|Wx::TR_ROW_LINES|Wx::TR_FULL_ROW_HIGHLIGHT|Wx::SUNKEN_BORDER

    treeCtrl = WxTreeCtrl.new(parent, TreeTest_Ctrl,
                              Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE,
                              style)
    treeCtrl
  end
  
  def creteInfoCtrl( parent )
    textCtrl = 
      Wx::TextCtrl.new(parent, -1, "", 
                       Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE, Wx::TE_MULTILINE|Wx::SUNKEN_BORDER)
    textCtrl    
  end

  def createLogCtrl( parent )
    # set our text control as the log target
    # create the controls
    textCtrl = 
      Wx::TextCtrl.new(parent, -1, "", 
                       Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE, Wx::TE_MULTILINE|Wx::SUNKEN_BORDER)
    logWindow = Wx::LogTextCtrl.new(textCtrl)
    Wx::Log::set_active_target(logWindow)
    textCtrl
  end

  #
  # Eventi
  #
  def on_dir_choose(event)
    # pass some initial dir to DirDialog
    dir_home = "."
    dialog = Wx::DirDialog.new(@frame, "Testing directory picker", dir_home)
    if dialog.show_modal() == Wx::ID_OK
      dirname = dialog.get_path
      Wx::log_message("Selected path: %s", dirname )
      @treeCtrl.makeTree( dirname )
    end
  end
  
  def on_close(event)
    Wx::Log::set_active_target(nil)
    destroy()
  end

  def on_quit(event)
    close(true)
  end

  def on_about(event)
    msg = "Tree test sample\n" + "(c) Tokiro 2007"
    title = "About tree test"
    Wx::message_box( msg, title,
                     Wx::OK|Wx::ICON_INFORMATION, 
                     @frame)
  end
  
end
