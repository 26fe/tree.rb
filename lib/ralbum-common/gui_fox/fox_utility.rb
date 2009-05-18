class FoxUtility
  
  def self.makeIcon(app, filename)
    filename = File.join($COMMON_HOME, "lib", "common", "gui_fox", "icons", filename)
    
    if not File.exist?( filename )
      raise RuntimeError, "file not exists: #{filename}"
    end
      
    begin
      icon = nil
      File.open(filename, "rb") do |f|
        icon = FXPNGIcon.new(app, f.read)
      end
      icon
    rescue
      raise RuntimeError, "Couldn't load icon: #{filename}"
    end
  end
  
end