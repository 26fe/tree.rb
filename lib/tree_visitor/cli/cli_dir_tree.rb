# stdlib
require 'optparse'

# common
require 'tree_visitor/dir_tree_walker'
require 'tree_visitor/build_dir_tree_visitor'

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

    dtw = DirTreeWalker.new( dirname )
    dtw.add_ignore_dir( ".svn" )
    dtw.add_ignore_dir( "catalog_data" )

    case options[:algo]
    when 'build'
      visitor = BuildDirTreeVisitor.new
      dtw.run( visitor )
      puts visitor.root.to_str
    when 'visit'  
      visitor = PrintDirTreeVisitor.new
      dtw.run( visitor )
    end

  end

end
