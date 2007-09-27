require 'rubygems'
require 'RMagick'
   
require 'wx'
   
Minimal_Quit = 1
Minimal_About = Wx::ID_ABOUT
   
  
class MyFrame < Wx::Frame

  def initialize(title,pos,size,style=Wx::DEFAULT_FRAME_STYLE)
    super(nil,-1,title,pos,size,style)
    menuFile = Wx::Menu.new
    helpMenu = Wx::Menu.new
    helpMenu.append(Minimal_About, "&About...\tF1", "Show about dialog")
    menuFile.append(Minimal_Quit, "E&xit\tAlt-X", "Quit this program")
    menuBar = Wx::MenuBar.new
    menuBar.append(menuFile, "&File")
    menuBar.append(helpMenu, "&Help")
    set_menu_bar(menuBar)
    create_status_bar(2)
    set_status_text("Welcome to wxRuby!")
    evt_menu(Minimal_Quit) {onQuit}
    evt_menu(Minimal_About) {onAbout}
 
    evt_paint do onPaint end
   

    #Load a bitmap into an RMagick image
    @img = Magick::Image.read("/home.local/ferro/dilbert2814760070903.gif").first

    #Create a wxImage to display--same dimensions as our RMagick image
    @wx_img = Wx::Image.new(@img.columns, @img.rows)

    #convert RMagick image to a displayable format and dump it into our wxImage
    @wx_img.set_data(@img.to_blob {
      self.format = "RGB"
      self.depth = 8 #TODO: set according to Wx's current display depth?
    }) 

    #create a WxBitmap for displaying on the device context (dc)
    @bitmap = Wx::Bitmap.new(@wx_img)
   
  end
 
  def onQuit
    close(TRUE)
  end
 
  def onAbout
    msg =  sprintf("This is the About dialog of the minimal sample.\nWelcome to %s", Wx::VERSION_STRING) 
    Wx::message_box(msg, "About Minimal", Wx::OK | Wx::ICON_INFORMATION)
  end
 
  def onPaint
    puts("onPaint begin")
    paint do | dc |
      dc.clear
      dc.draw_bitmap(@bitmap, 0, 0, false)
    end
    puts("onPaint end")
  end
end
 
class RbApp < Wx::App
  def on_init
    frame = MyFrame.new("Minimal wxRuby App",Wx::Point.new(50, 50), Wx::Size.new(450, 340))
    frame.show(TRUE)
  end
end
 
Wx::init_all_image_handlers
a = RbApp.new
a.main_loop()
