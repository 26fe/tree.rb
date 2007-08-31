class WxTreeNodeViewerApp < Wx::App
  def initialize
    super
  end
  
  def on_init
    # Create the main frame window
    frame = WxTreeNodeViewerFrame.new("TreeCtrl Test", 50, 50, 450, 600)

    # show the frame
    frame.show(true)
  end
end
