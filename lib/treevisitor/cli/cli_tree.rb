# -*- coding: utf-8 -*-
module TreeVisitor
  #
  #
  #
  class CliTree

    def self.run
      self.new.parse_args(ARGV)
    end

    def parse_args(argv)

      options     = {:verbose => true, :force => false, :algo => 'build-dir'}

      opts        = OptionParser.new
      opts.banner = "Usage: tree.rb [options] [directory]"

      opts.separator ""
      opts.separator "list contents of directories in a tree-like format"
      opts.separator "this is a almost :-) a clone of tree unix command written in ruby"

      opts.separator ""
      opts.separator "options: "

      opts.on("-h", "--help", "Show this message") do
        puts opts
        return 0
      end

      opts.on("--version", "Show the version") do
        puts "tree.rb version #{TreeVisitor::version}"
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

      algos        = %w[build-dir print-dir json yaml]
      algo_aliases = {"b" => "build-dir", "v" => "print-dir", "j" => "json", "y" => "yaml"}

      algo_list    = (algo_aliases.keys + algos).join(',')
      opts.on("--visitor ALGO", algos, algo_aliases, "select an algo", "  (#{algo_list})") do |algo|
        options[:algo] = algo
      end

      rest = opts.parse(argv)

      if rest.length < 1
        dirname = Dir.pwd
      else
        dirname = rest[0]
      end

      dirname = File.expand_path(dirname)

      dtw     = DirTreeWalker.new(dirname)
      unless options[:all_files]
        dtw.ignore(/^\.[^.]+/) # ignore all file starting with "."
      end

      dtw.visit_file = !options[:only_directories]

      case options[:algo]
        when 'build-dir'
          visitor = BuildDirTreeVisitor.new
          dtw.run(visitor)
          puts visitor.root.to_str
          puts
          puts "#{visitor.nr_directories} directories, #{visitor.nr_files} files"
        when 'print-dir'
          visitor = PrintDirTreeVisitor.new
          dtw.run(visitor)
        when 'json'
          root = dtw.run(DirectoryToHashVisitor.new(dirname)).root
          puts JSON.pretty_generate(root)
        when 'yaml'
          root = dtw.run(DirectoryToHashVisitor.new(dirname)).root
          puts root.to_yaml
        else
          puts "unknown algo #{options[:algo]} specified"
      end

      0
    end

  end
end
