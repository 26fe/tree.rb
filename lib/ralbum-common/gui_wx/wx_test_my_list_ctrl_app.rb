class WXTestListCtrlApp < Wx::App

  def initialize
    super
  end
  
  def on_init
    # Create the main frame window
    @frame = Wx::Frame.new(nil, -1, "Test", Wx::Point.new(50, 50), Wx::Size.new(200, 200))

    makeMenubar( @frame )
    # create splitter
    splitter = Wx::SplitterWindow.new(@frame, -1)

    @log = createLogCtrl( splitter )
    @listCtrl = WXMyListCtrl.new( splitter, @log )
        
    splitter.set_minimum_pane_size(20)
    splitter.split_horizontally(@listCtrl, @log, -50)

    @frame.show(true)
  end
  
  def makeMenubar( frame )
    file_menu  = Wx::Menu.new

    file_menu.append(Wx::ID_ABOUT, "&About...")
    file_menu.append_separator()
    file_menu.append(Wx::ID_EXIT, "E&xit\tAlt-X")

    menu_bar = Wx::MenuBar.new
    menu_bar.append(file_menu, "&File")
    frame.set_menu_bar(menu_bar)

    evt_menu(Wx::ID_EXIT) {|event| on_quit(event) }
    evt_menu(Wx::ID_ABOUT) {|event| on_about(event) }

    style_menu = Wx::Menu.new
    
    style_menu.append(StyleMenuLCList,      "list",       "", Wx::ITEM_CHECK)
    style_menu.append(StyleMenuLCReport,    "report",     "", Wx::ITEM_CHECK)
    style_menu.append(StyleMenuLCIcon,      "icon",       "", Wx::ITEM_CHECK)
    style_menu.append(StyleMenuLCSmallIcon, "small icon", "", Wx::ITEM_CHECK)
    
    menu_bar.append( style_menu, "&Style")
    
    evt_menu(StyleMenuLCList) { |event| 
      tog_style(event.get_id(), Wx::LC_LIST)
    }
    evt_menu(StyleMenuLCReport) { |event| 
      tog_style(event.get_id(), Wx::LC_REPORT)
    }
    evt_menu(StyleMenuLCIcon) { |event| 
      tog_style(event.get_id(), Wx::LC_ICON)
    }
    evt_menu(StyleMenuLCSmallIcon) { |event| 
      tog_style(event.get_id(), Wx::LC_SMALL_ICON)
    }
  
  end

  def tog_style(id, flag)

    style = @listCtrl.get_window_style_flag() ^ flag

    @listCtrl.set_window_style_flag( style )
    @listCtrl.addItems
    # most treectrl styles can't be changed on the fly using the native
    # control and the tree must be recreated
    # @treectrl.destroy
    # create_tree(style)
    @frame.get_menu_bar().check(id, (style & flag) != 0)
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
  
end
