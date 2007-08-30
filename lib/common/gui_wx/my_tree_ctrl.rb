class MyTreeCtrl < Wx::TreeCtrl
  
  def initialize(parent, id,pos, size,style)
    super(parent, id, pos, size, style)

    @reverse_sort = false

    create_image_list

    # add some items to the tree
    add_test_items_to_tree(5, 2)
  end

  def show_info(id)
    Wx::log_message("Item '%s': %sselected, %sexpanded, %sbold,\n" +
                "%d children (%d immediately under selected item).",
                get_item_text( id ),
                bool_to_str( is_selected( id ) ),
                bool_to_str( is_expanded( id ) ),
                bool_to_str( is_bold( id ) ),
                get_children_count( id ),
                get_children_count(id, false) )
  end

  def bool_to_str(bool)
    bool ? " " : "not "
  end

  def do_ensure_visible()
    ensure_visible(@last_item)
  end

  def image_size()
    return @image_size
  end

  def is_test_item(item)
    # the test item is the first child folder
    return get_item_parent(item) == get_root_item() && !get_prev_sibling(item)
  end

  def create_image_list
    @imageSize = 16

    # Make an image list containing small icons
    images = Wx::ImageList.new(32, 32, true)
    # should correspond to TreeCtrlIcon_xxx enum
    Wx::BusyCursor.busy do
      icons = (1 .. 5).map do | i |
        icon_filename = File.join($COMMON_HOME, "lib", "common", "gui_wx", "icons", "icon#{i}.xpm")
        Wx::Bitmap.new(icon_filename, Wx::BITMAP_TYPE_XPM)
      end
      icons.each { | ic | images.add(ic) }
      set_image_list(images)
    end
  end

  def unset_image_list
    set_image_list(nil)
  end

  def create_buttons_image_list()
    # Make an image list containing small icons
    images = Wx::ImageList.new(16, 16, true)

    # should correspond to TreeCtrlIcon_xxx enum
    Wx::BusyCursor.busy do |x|
      icons = [
        Wx::Icon.new("icon3.xpm"),   # closed
        Wx::Icon.new("icon3.xpm"),   # closed, selected
        Wx::Icon.new("icon5.xpm"),   # open
        Wx::Icon.new("icon5.xpm")]   # open, selected
      
      icons.each do | ic |
        orig_size = ic.get_width()
        if size == orig_size
          images.add(ic)
        else
          resized = ic.convert_to_image().rescale(size, size)
          images.add( Wx::Bitmap.new(resized) )
        end
      end
      
      set_buttons_image_list(images)
    end
  end

  def add_items_recursively(parent_id, num_children, depth, folder)
    if depth > 0
      has_children = depth > 1

      for n in 0 ... num_children
        # at depth 1 elements won't have any more children
        if has_children
          str = sprintf("%s child %d", "Folder", n + 1)
        else
          str = sprintf("%s child %d.%d", "File", folder, n + 1)
        end
        # here we pass to append_item() normal and selected item images (we
        # suppose that selected image follows the normal one in the enum)
        image = depth == 1 ? TreeCtrlIcon_File : TreeCtrlIcon_Folder
        imageSel = image + 1
        id = append_item(parent_id, str, image, imageSel)

        # and now we also set the expanded one (only for the folders)
        if has_children 
          set_item_image(id, TreeCtrlIcon_FolderOpened,
                         Wx::TREE_ITEM_ICON_EXPANDED)
        end

        # remember the last child for OnEnsureVisible()
        if ! has_children && n == num_children - 1
          @last_item = id
        end

        add_items_recursively(id, num_children, depth - 1, n + 1)
      end
    end
  end

  def add_test_items_to_tree(num_children,depth)
    image = TreeCtrlIcon_Folder
    root_id = add_root("Root",image, image)
    if image != -1
      set_item_image(root_id, TreeCtrlIcon_FolderOpened, 
                      Wx::TREE_ITEM_ICON_EXPANDED)
    end

    add_items_recursively(root_id, num_children, depth, 0)

    # set some colours/fonts for testing
    # note that font sizes can also be varied, but only on platforms
    # that use the generic TreeCtrl - OS X and GTK, and only if
    # Wx::TR_HAS_VARIABLE_ROW_HEIGHT style was used in the constructor
    font = get_font
    font.set_style(Wx::FONTSTYLE_ITALIC)
    set_item_font(root_id, font)

    id,cookie = get_first_child(root_id)
    set_item_text_colour(id, Wx::BLUE)

    id,cookie = get_next_child(root_id,cookie)
    id,cookie = get_next_child(root_id,cookie)
    if Wx::PLATFORM == "WXMSW"
      set_item_text_colour(id, Wx::RED)      
      set_item_background_colour(id, Wx::LIGHT_GREY)
    end
  end


  def do_toggle_icon(item)
    old_img = get_item_image(item)
    if old_img == TreeCtrlIcon_Folder
      new_img = TreeCtrlIcon_File
    else
      new_img = TreeCtrlIcon_Folder
    end

    set_item_image(item, new_img)
  end

  def on_get_info(event)
    Wx::log_message("OnGetInfo")
    event.skip()
  end

  def on_set_info(event)
    Wx::log_message("OnSetInfo")
    event.skip()
  end

  def on_sel_changed(event)
    Wx::log_message("OnSelChanged")
    event.skip()
  end

  def on_sel_changing(event)
    Wx::log_message("OnSelChanging")
    event.skip()
  end

  # show some info about activated item
  def on_item_activated(event)
    item_id = event.get_item()
    if item_id
      show_info(item_id)
    end
    Wx::log_message("OnItemActivated")
  end

  def show_popup_menu(id, pos)
    title = ""
    if id.nonzero?
      title << "Menu for " << get_item_text(id)
    else
      title = "Menu for no particular item"
    end

    menu = Wx::Menu.new(title)
    menu.append(Wx::ID_ABOUT, "&About...")
    menu.append(TreeTest_Dump, "&Dump")
    popup_menu(menu, pos)
  end

end
