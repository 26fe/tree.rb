DIALOGS_DIR_CHOOSE = 100

class MyFrame < Wx::Frame
  
  def initialize(title, x, y, w, h)
    super(nil, -1, title, Wx::Point.new(x, y), Wx::Size.new(w, h))
    @treectrl = nil
    @textctrl = nil

    # This reduces flicker effects - even better would be to define
    # OnEraseBackground to do nothing. When the tree control's scrollbars are
    # show or hidden, the frame is sent a background erase event.
    set_background_colour(Wx::Colour.new(255, 255, 255))

    # Make a menubar
    file_menu  = Wx::Menu.new

    file_menu.append(DIALOGS_DIR_CHOOSE,  "&Choose a directory\tCtrl-D")
    file_menu.append(Wx::ID_ABOUT, "&About...")
    file_menu.append_separator()
    file_menu.append(Wx::ID_EXIT, "E&xit\tAlt-X")

    menu_bar = Wx::MenuBar.new
    menu_bar.append(file_menu, "&File")
    set_menu_bar(menu_bar)

    # create the controls
    @textctrl = Wx::TextCtrl.new(self, -1, "",
                             Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE,
                             Wx::TE_MULTILINE|Wx::SUNKEN_BORDER)

    create_tree_with_default_style()

    # create a status bar with 3 panes
    create_status_bar(3)
    set_status_text("", 0)

    # set our text control as the log target
    logWindow = Wx::LogTextCtrl.new(@textctrl)
    Wx::Log::set_active_target(logWindow)


    evt_menu(Wx::ID_EXIT) {|event| on_quit(event) }
    evt_menu(Wx::ID_ABOUT) {|event| on_about(event) }
    evt_menu(DIALOGS_DIR_CHOOSE) {|event| on_dir_choose(event) }

    evt_size {|event| on_size(event) }
    evt_close {|event| on_close(event) }
  end

  def on_dir_choose(event)

    # pass some initial dir to DirDialog
    dir_home = "."

    dialog = Wx::DirDialog.new(self, "Testing directory picker", dir_home)

    if dialog.show_modal() == ID_OK
      # log_message("Selected path: %s", dialog.get_path())
    end
  end
  

  def create_tree_with_default_style()

    style = Wx::TR_DEFAULT_STYLE|Wx::TR_EDIT_LABELS|
            Wx::TR_TWIST_BUTTONS|Wx::TR_ROW_LINES|Wx::TR_FULL_ROW_HIGHLIGHT

    create_tree(style|Wx::SUNKEN_BORDER)
  end

  def create_tree(style)
    @treectrl = MyTreeCtrl.new(self, TreeTest_Ctrl,
                               Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE,
                               style)
    resize()
  end


  def on_size(event)
    if @treectrl && @textctrl
      resize()
    end

    event.skip()
  end

  def resize()
    my_size = get_client_size()
    tree_size = Wx::Size.new(my_size.x, 2*my_size.y/3)
    @treectrl.set_size( tree_size )
    @textctrl.set_dimensions(0, 2*my_size.y/3, my_size.x, my_size.y/3)
  end

  def on_close(event)
    Wx::Log::set_active_target(nil)
    destroy()
  end

  def on_quit(event)
    close(true)
  end

  def on_about(event)
    Wx::message_box("Tree test sample\n" +
                                      "(c) Julian Smart 1997, Vadim Zeitlin 1998",
                "About tree test",
                Wx::OK|Wx::ICON_INFORMATION, self)
  end

end
