# -*- coding: utf-8 -*-
module TreeRb
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
      opts.separator "list contents of directories in a tree-like format"
      opts.separator "this is a almost :-) a clone of tree unix command written in ruby"
      opts.separator "Code https://github.com/tokiro/treevisitor. Feedback to tokiro.oyama@gmail.com"

      opts.separator ""
      opts.separator "options: "

      opts.on("-h", "--help", "Show this message") do
        puts opts
        return 0
      end

      opts.on("--version", "Show the version") do
        puts "tree.rb version #{TreeRb::VERSION}"
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
      opts.on("-f", "--format ALGO", algos, algo_aliases, "select an algo", "  (#{algo_list})") do |algo|
        options[:algo] = algo
      end

      begin
        rest = opts.parse(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.to_s
        $stderr.puts "try -h for help"
        return false
      end

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
          # TODO: capture CTRL^C
          # http://ruby-doc.org/core-1.9.3/Kernel.html#method-i-trap
          Kernel.trap('INT') { put "User interrupted exit"; exit; }

          visitor = BuildDirTreeVisitor.new
          dtw.run(visitor)

          # colors also in windows
          if $stdout.isatty
            puts visitor.root.to_str('', true)  #use color
          else
            puts visitor.root.to_str
          end
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
