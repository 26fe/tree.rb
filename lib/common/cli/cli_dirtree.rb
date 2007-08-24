require 'optparse'
require 'common/builddirtree_processor'
require 'common/visitdirtree_processor'

#
#
#
class CliDirTree

  def self.run
    self.new.parse_args( ARGV )
  end

  def parse_args( argv )

    options = { :verbose => true, :force => false, :algo => 'build' }

    opts = OptionParser.new
    opts.banner = "Usage: example.rb [options]"
    
    opts.separator ""
    opts.separator "programma per testare la classe DirProcessor"
    opts.separator "Inserire il nome della directory da cui costuire il tree"
    
    opts.separator ""
    opts.separator "opzioni: "
    
    opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end

    opts.on("-q", "--quiet", "quiet mode as --no-verbose") do |v|
      options[:verbose] = false
    end
    
    opts.on("-h", "--help", "Show this message") do
      puts opts
      exit
    end


    algos = %w[build visit]
    algo_aliases = { "b" => "build", "v" => "visit" }

    algo_list = (algo_aliases.keys + algos).join(',')
    opts.on("-a", "--algo ALGO", algos, algo_aliases, "Select algo","  (#{algo_list})") do |algo|
      options[:algo] = algo
    end

    rest = opts.parse(argv)

    # p options
    # p ARGV

    if rest.length < 1
      puts opts
      return 1
    end

    dirname = rest[0]
    dirname = File.expand_path( dirname )

    puts "reading : #{dirname}"

    pdt =
      case options[:algo]
      when 'build' then BuildDirTreeProcessor.new( dirname )
      when 'visit' then VisitDirTreeProcessor.new( dirname )
      end

    pdt.add_ignore_dir( ".svn" )
    pdt.add_ignore_dir( "catalog_data" )
    treeNode = pdt.run

    if treeNode
      puts treeNode.to_s()
    end

  end

end
