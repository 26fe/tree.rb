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


class MyApp < Wx::App

  def initialize
    super
  end
  
  def on_init
    # Create the main frame window
    frame = Wx::Frame.new(nil, -1, "Test", Wx::Point.new(50, 50), Wx::Size.new(200, 200))

    # create splitter
    splitter = Wx::SplitterWindow.new(frame, -1)
    
    p1 = Wx::Window.new(splitter, -1)
    p1.set_background_colour(Wx::RED)
    Wx::StaticText.new(p1, -1, "Panel One", Wx::Point.new(5,5)).set_background_colour(Wx::RED)
    
    p2 = Wx::Window.new(splitter, -1)
    p2.set_background_colour(Wx::BLUE)
    Wx::StaticText.new(p2, -1, "Panel Two", Wx::Point.new(5,5)).set_background_colour(Wx::BLUE)
    
    splitter.set_minimum_pane_size(20)
    splitter.split_vertically(p1, p2, -50)

    frame.show(true)
  end
end

a = MyApp.new
a.main_loop()

