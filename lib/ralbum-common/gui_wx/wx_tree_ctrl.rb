# common
require 'common/dir_tree_walker'
require 'common/gui_wx/wx_constants'
require 'common/gui_wx/wx_dir_tree_visitor'

class WxTreeCtrl < Wx::TreeCtrl
  
  def initialize(parent, id,pos, size,style)
    super(parent, id, pos, size, style)
    # makeTree(".")
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

#  def create_image_list
#    @imageSize = 16
#
#    # Make an image list containing small icons
#    images = Wx::ImageList.new(32, 32, true)
#    # should correspond to TreeCtrlIcon_xxx enum
#    Wx::BusyCursor.busy do
#      icons = (1 .. 5).map do | i |
#        icon_filename = File.join($COMMON_HOME, "lib", "common", "gui_wx", "icons", "icon#{i}.xpm")
#        Wx::Bitmap.new(icon_filename, Wx::BITMAP_TYPE_XPM)
#      end
#      icons.each { | ic | images.add(ic) }
#      set_image_list(images)
#    end
#  end

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

  #
  #
  #
  
  def makeTree( dirname )
    dirname = File.expand_path( dirname )
    
    # Wx::log_message "reading : #{dirname}"

    dtw = DirTreeWalker.new( dirname )
    dtw.add_ignore_dir( ".svn" )
    dtw.add_ignore_dir( "catalog_data" )
    visitor = WxDirTreeVisitor.new( self ) 
    dtw.run( visitor )
  end

end
