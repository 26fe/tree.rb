require 'optparse'
require 'common/printdirtree_processor'

#
#
#
class CliPrintDirTree

  def self.run
    self.new.parse_args( ARGV )
  end

  def parse_args( argv )

    options = { :verbose => true, :force => false }

    opts = OptionParser.new
    opts.banner = "Usage: example.rb [options]"

    opts.on("-h", "--help", "Print this message") do
      puts opts
      return
    end

    opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end

    opts.on("-q", "--quiet", "quiet mode as --no-verbose") do |v|
      options[:verbose] = false
    end

    rest = opts.parse(argv)

    # p options
    # p ARGV

    if rest.length < 1
      puts "inserire il nome della directory di cui creare il catalogo"
      puts "-h to print help"
      return
    end

    dirname = rest[0]
    dirname = File.expand_path( dirname )

    puts dirname

    pdt = PrintDirTreeProcessor.new( dirname )
    treeNode = pdt.run

    puts treeNode.convert()

  end

end
