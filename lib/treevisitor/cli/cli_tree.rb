# stdlib
require 'optparse'

# treevisitor
require 'treevisitor'
require 'treevisitor/dir_tree_walker'
require 'treevisitor/visitors/build_dir_tree_visitor'
require 'treevisitor/visitors/print_dir_tree_visitor'

#
#
#
class CliTree

  def self.run
    self.new.parse_args( ARGV )
  end

  def parse_args( argv )

    options = { :verbose => true, :force => false, :algo => 'build' }

    opts = OptionParser.new
    opts.banner = "Usage: tree.rb [options] [directory]"
    
    opts.separator ""
    opts.separator "list contents of directories in a tree-like format"
    opts.separator "this is a clone of tree unix command written in ruby"
    
    opts.separator ""
    opts.separator "options: "
    
    opts.on("-h", "--help", "Show this message") do
      puts opts
      return 0
    end

    opts.on("--version", "Show the version") do
      puts "tree.rb version #{TreeVisitor::VERSION}"
      return 0
    end

    opts.on("-a", "All file are listed") do |v|
      options[:all_files] = true
    end

    opts.on("-d", "List directories only") do |v|
      options[:only_directories] = true
    end

    opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end

    opts.on("-q", "--quiet", "quiet mode as --no-verbose") do |v|
      options[:verbose] = false
    end
    
    algos = %w[build visit]
    algo_aliases = { "b" => "build", "v" => "visit" }

    algo_list = (algo_aliases.keys + algos).join(',')
    opts.on("--algo ALGO", algos, algo_aliases, "Select algo","  (#{algo_list})") do |algo|
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

    # puts "reading : #{dirname}"

    dtw = DirTreeWalker.new( dirname )
    unless options[:all_files]
      dtw.add_ignore_pattern(/^\.[^.]+/) # ignore all file starting with "."
    end

    dtw.visit_leaf = !options[:only_directories]

    case options[:algo]
    when 'build'
      visitor = BuildDirTreeVisitor.new
      dtw.run( visitor )
      puts visitor.root.to_str
      puts 
      puts "#{visitor.nr_directories} directories, #{visitor.nr_files} files"
    when 'visit'  
      visitor = PrintDirTreeVisitor.new
      dtw.run( visitor )
    end

  end

end
