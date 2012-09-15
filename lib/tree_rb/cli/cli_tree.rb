# -*- coding: utf-8 -*-
module TreeRb

  #
  #
  #
  class CliTree

    def self.run
      self.new.parse_args(ARGV)
    end

    def options_parser(options)
      parser        = OptionParser.new
      parser.banner = "Usage: tree.rb [options] [directory]"
      parser.separator "list contents of directories in a tree-like format"
      parser.separator "this is a almost :-) a clone of tree unix command written in ruby"
      parser.separator "Code https://github.com/tokiro/treevisitor. Feedback to tokiro.oyama@gmail.com"

      #
      # Generic
      #
      parser.separator ""
      parser.separator "Generic options: "

      parser.on_tail("--help", "Show this message") do
        puts parser
        options[:exit] = 1
      end

      parser.on_tail("--version", "Show the version") do
        puts "tree.rb version #{TreeRb::VERSION}"
        options[:exit] = 1
      end

      parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      parser.on("-q", "--quiet", "quiet mode as --no-verbose") do
        options[:verbose] = false
      end

      parser.on("-o [FILE]", "--output [FILE]", String) do |v|
        if options[:output]
          puts "only one file of output can be used"
          options[:exit] = true
        end
        options[:output] = v
      end

      options[:force_overwrite_output] = false
      parser.on("--force", "overwrite output") do
        options[:force_overwrite_output] = true
      end

      #
      # Filters
      #
      parser.separator ""
      parser.separator "Filter options: "

      parser.on("-a", "All file are listed i.e. include dot files") do
        options[:all_files] = true
      end

      parser.on("-d", "List directories only") do
        options[:only_directories] = true
      end

      options[:only_files] = false
      parser.on("--only-files", "show only file implies -i") do
        options[:only_files]       = true
        options[:show_indentation] = false
      end

      algos        = %w[build-dir print-dir json json2 yaml sqlite]
      algo_aliases = { "b" => "build-dir", "v" => "print-dir", "j" => "json", "y" => "yaml", "s" => "sqlite" }

      algo_list = (algo_aliases.keys + algos).join(',')
      parser.on("--format ALGO", algos, algo_aliases, "select an algo", "  (#{algo_list})") do |algo|
        options[:algo] = algo
      end

      options[:max_level] = nil
      parser.on("-L [LEVEL]", Integer, "Max display depth of the directory tree.") do |l|
        options[:max_level] = l
      end

      #
      # Presentation options
      #
      parser.separator ""
      parser.separator "print options:"

      #
      # begin colorize
      #
      # copied from tree man page
      parser.on("-n", "Turn colorization off always, over-ridden by the -C option.") do
        options[:colorize_force] = false
      end

      # copied from tree man page
      parser.on("-C",
                "Turn colorization on always, using built-in color",
                "  defaults if the LS_COLORS environment variable is not set.",
                "  Useful to colorize output to a pipe.") do
        options[:colorize_force] = true
      end
      #
      # end colorize
      #

      options[:ansi_line_graphics] = false
      parser.on("-A", "Turn on ANSI line graphics hack when printing the indentation lines.") do
        options[:ansi_line_graphics] = true
      end

      options[:show_full_path] = false
      parser.on("-f", "Prints the full path prefix for each file.") do
        options[:show_full_path] = true
      end

      parser.on("-s", "Print the size of each file in bytes along with the name.") do
        options[:show_size] = true
      end

      parser.on("-h",
                "Print the size of each file but in a more human readable way,",
                "  e.g. appending  a  size  letter  for  kilobytes  (K), megabytes (M),",
                "  gigabytes (G), terrabytes (T), petabytes (P) and exabytes (E).") do
        options[:show_size_human] = true
      end

      options[:show_indentation] = true
      parser.on("-i",
                "Makes tree not print the indentation lines, ",
                "  useful when used in conjunction with the -f option.") do
        options[:show_indentation] = false
      end

      options[:show_md5] = false
      parser.on("--md5", "show md5 of file") do
        options[:show_md5] = true
      end

      options[:show_sha1] = false
      parser.on("--sha1", "show sha1 of a file") do
        options[:show_sha1] = true
      end

      options[:show_report] = true
      parser.on("--noreport", "Omits printing of the file and directory report at the end of the tree listing.") do
        options[:show_report] = false
      end

      parser.separator ""
      parser.separator "shortcut options:"

      options[:show_md5sum] = false
      parser.on("--md5sum", "show ake md5sum implies -i and --only-files") do
        options[:only_files]       = true
        options[:show_md5sum]      = true
        options[:show_indentation] = false
        options[:show_report]      = false
      end

      options[:show_sha1sum] = false
      parser.on("--sha1sum", "show ake sha1sum output implies -i and --only-files") do
        options[:only_files]       = true
        options[:show_sha1sum]     = true
        options[:show_indentation] = false
        options[:show_report]      = false
      end


      parser
    end

    def parse_args(argv)
      options = { :verbose => true, :force => false, :algo => 'build-dir' }
      parser  = options_parser(options)

      begin
        rest = parser.parse(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.to_s
        $stderr.puts "try --help for help"
        return false
      rescue OptionParser::MissingArgument => e
        $stderr.puts e.to_s
        $stderr.puts "try --help for help"
        return false
      end

      unless options[:exit].nil?
        return options[:exit]
      end

      #
      # option: output, force
      #
      output = $stdout
      if options[:output]
        filename = options[:output]
        if File.exist?(filename) and not options[:force_overwrite_output]
          $stderr.puts "catalog '#{filename}' exists use --force to overwrite"
          return 0
        end
        output = File.open(filename, "w")
        $stderr.puts "Writing file '#{filename}'"
      end

      if options[:colorize_force]
        options[:colorize] = options[:colorize_force]
      else
        options[:colorize] = output.isatty
      end

      # TODO: capture CTRL^C to avoid show the stack trace
      # http://ruby-doc.org/core-1.9.3/Kernel.html#method-i-trap
      Signal.trap('INT') { puts "intercepted ctr+c"; exit }

      if rest.length < 1
        dirname = Dir.pwd
      else
        dirname = rest[0]
      end

      #
      # 1. build dir tree walker
      #
      dirname = File.expand_path(dirname)
      dtw     = DirTreeWalker.new(dirname, options)
      unless options[:all_files]
        dtw.ignore(/^\.[^.]+/) # ignore all file starting with "."
      end
      dtw.visit_file = !options[:only_directories]

      case options[:algo]

        when 'build-dir'

          visitor = BuildDirTreeVisitor.new(options)
          dtw.run(visitor)

          output.puts visitor.root.to_str('', options)

          if options[:show_report]
            output.puts
            output.puts "#{visitor.nr_directories} directories, #{visitor.nr_files} files"
          end

        when 'print-dir'
          visitor = PrintDirTreeVisitor.new
          dtw.run(visitor)

        when 'json'
          visitor = DirectoryToHashVisitor.new(dirname)
          root    = dtw.run(visitor).root
          begin
            output.puts JSON.pretty_generate(root)
          rescue JSON::NestingError => e
            $stderr.puts "#{File.basename(__FILE__)}:#{__LINE__} #{e.to_s}"
          end

        when 'json2'
          visitor = DirectoryToHash2Visitor.new(dirname)
          root    = dtw.run(visitor).root
          begin
            output.puts JSON.pretty_generate(root)
          rescue JSON::NestingError => e
            $stderr.puts "#{File.basename(__FILE__)}:#{__LINE__} #{e.to_s}"
          end

        when 'yaml'
          visitor = DirectoryToHashVisitor.new(dirname)
          root    = dtw.run(visitor).root
          output.puts root.to_yaml

        when 'sqlite'
          begin
            require 'sqlite3'
            unless options[:output]
              $stderr.puts "need to specify the -o options"
            else
              output.close
              filename = options[:output]
              visitor  = SqliteDirTreeVisitor.new(filename)
              #start = Time.now
              #me    = self
              #bytes = 0
              dtw.run(visitor)
            end

          rescue LoadError
            puts 'You must gem install sqlite3 to use this output format'
          end

        else
          puts "unknown algo #{options[:algo]} specified"
      end

      0
    end

  end # end class
end # end module
