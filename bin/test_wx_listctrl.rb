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



class TestVirtualList < Wx::ListCtrl
    def initialize(parent, log)
        super(parent, -1, 
              Wx::DEFAULT_POSITION, Wx::DEFAULT_SIZE, 
              Wx::LC_SMALL_ICON | Wx::LC_HRULES | Wx::LC_VRULES)
        @log = log
        
        @il = Wx::ImageList.new(16,16)
        
        bmp_file = File.join($COMMON_HOME, "lib", "common", "gui_wx", "icons/wxwin16x16.xpm")
        @idx1 = @il.add(Wx::Bitmap.new(bmp_file))
        set_image_list(@il, Wx::IMAGE_LIST_SMALL)
        
        insert_column(0,"First")
        insert_column(1,"Second")
        insert_column(2,"Third")
        set_column_width(0,175)
        set_column_width(1,175)
        set_column_width(2,175)
        
        # set_item_count(1000000)
        
        @attr1 = Wx::ListItemAttr.new()
        @attr1.set_background_colour(Wx::Colour.new("YELLOW"))
        
        @attr2 = Wx::ListItemAttr.new()
        @attr2.set_background_colour(Wx::Colour.new("LIGHT BLUE"))
        
        evt_list_item_selected(get_id()) {|event| on_item_selected(event)}
        evt_list_item_activated(get_id()) {|event| on_item_activated(event)}
        evt_list_item_deselected(get_id()) {|event| on_item_deselected(event)}
        
        listItem = Wx::ListItem.new
        listItem.set_id( 0 )
        listItem.set_text( "prova" )
        listItem.set_image( @idx1 )
        # listItem.set_column(0, "prova")
        insert_item(listItem)
        
    end
    
    def on_item_selected(event)
        @currentItem = event.get_index()
        @item = event.get_item()
        get_column(1,@item)
        
        @log.write_text('on_item_selected: "%s", "%s", "%s", "%s"' % [@currentItem, get_item_text(@currentItem), 
                            @item.get_text(), get_column(2,@item) ? @item.get_text() : nil])
    end
    
    def on_item_activated(event)
        @currentItem = event.get_index()
        @log.write_text("on_item_activated: %s\nTopItem: %s" % [get_item_text(@currentItem), get_top_item()])
    end
    
    def on_item_deselected(event)
        @log.write_text("on_item_deselected: %s" % event.get_index())
    end
    
end




class MyApp < Wx::App

  def initialize
    super
  end
  
  def on_init
    # Create the main frame window
    frame = Wx::Frame.new(nil, -1, "Test", Wx::Point.new(50, 50), Wx::Size.new(200, 200))

    # create splitter
    splitter = Wx::SplitterWindow.new(frame, -1)

    log = createLogCtrl( splitter )
    p1 = TestVirtualList.new( splitter, log )
        
    splitter.set_minimum_pane_size(20)
    splitter.split_horizontally(p1, log, -50)

    frame.show(true)
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

a = MyApp.new
a.main_loop()

