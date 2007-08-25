require 'pathname'

class DirProcessor

  def initialize( dirname, &action )
    @dirname = dirname
    @processors = {}
    @default_processor = action
  end

  def add_processor( re, &action )
    @processors[ re ] = action
  end

  def run()
    old_dirname = Dir.pwd
    Dir.chdir( @dirname )
    Dir["**/*"].each { |f|
      pn = Pathname.new( f ).expand_path
      # puts "#{self.class.name}#loadfromdir #{f}"
      next if pn.directory?
      process_file( pn )
    }
    Dir.chdir( old_dirname )
    self
  end

  private

  def process_file( pn )
    # puts "file: #{f}"
    pair = @processors.find { |re,action| re =~ pn.to_s }
    unless pair.nil?
       pair[1].call( pn )
    else
       @default_processor.call( pn ) if @default_processor
    end
  end

end
