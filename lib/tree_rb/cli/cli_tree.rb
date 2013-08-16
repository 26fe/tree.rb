# -*- coding: utf-8 -*-
module TreeRb

  #
  # Command Line Interface to Tree
  #
  class CliTree

    def self.run
      self.new.parse_args(ARGV)
    end

    def options_parser(options)
      parser        = OptionParser.new
      parser.banner = 'Usage: tree.rb [options] [directory]'
      parser.separator 'list contents of directories in a tree-like format'
      parser.separator 'this is a almost :-) a clone of tree unix command written in ruby'
      parser.separator 'Code https://github.com/tokiro/treevisitor. Feedback to tokiro.oyama@gmail.com'

      #
      # Generic
      #
      parser.separator ""
      parser.separator "Generic options: "

      parser.on("--help", "Show this message") do
        puts parser
        options[:exit] = 1
      end

      parser.on("--version", "Show the version") do
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

      formats = %w[build-dir print-dir json d3js html_partition html_tree html_treemap yaml sqlite dircat]
      # algo_aliases = { "b" => "build-dir", "v" => "print-dir", "j" => "json", "y" => "yaml", "s" => "sqlite" }
      # algo_list = (algo_aliases.keys + formats).join(',')
      parser.on('--format FORMAT', formats, 'select a output format', "  (#{formats})") do |format|
        options[:format] = format
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
                'Turn colorization on always, using built-in color',
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
                "  gigabytes (G), terabytes (T), petabytes (P) and exabytes (E).") do
        options[:show_size_human] = true
      end

      options[:show_indentation] = true
      parser.on("-i",
                'Makes tree not print the indentation lines, ',
                '  useful when used in conjunction with the -f option.') do
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
      parser.on("--no-report", "Omits printing of the file and directory report at the end of the tree listing.") do
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
      parser.on('--sha1sum', 'show ake sha1sum output implies -i and --only-files') do
        options[:only_files]       = true
        options[:show_sha1sum]     = true
        options[:show_indentation] = false
        options[:show_report]      = false
      end


      parser
    end

    def parse_args(argv)
      options = { :verbose => true, :force => false, :format => 'build-dir' }
      parser  = options_parser(options)

      begin
        rest = parser.parse(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.to_s
        $stderr.puts 'try --help for help'
        return false
      rescue OptionParser::MissingArgument => e
        $stderr.puts e.to_s
        $stderr.puts 'try --help for help'
        return false
      rescue OptionParser::InvalidArgument => e
        $stderr.puts e.to_s
        $stderr.puts 'try --help for help'
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
      Signal.trap('INT') do
        puts 'intercepted ctr+c'
        exit
      end

      if rest.length < 1
        dirname = Dir.pwd
      else
        dirname = rest[0]
      end

      #
      # 1. build dir tree walker
      #

      dirname = File.expand_path(dirname)
      begin
        directory_tree_walker = DirTreeWalker.new(dirname, options)
      rescue ArgumentError => e
        $stderr.puts e.to_s
        return false
      end
      unless options[:all_files]
        directory_tree_walker.ignore(/^\.[^.]+/) # ignore all file starting with "."
      end
      directory_tree_walker.visit_file = !options[:only_directories]

      case options[:format]

        when 'build-dir'

          visitor = BuildDirTreeVisitor.new(options)
          directory_tree_walker.run(visitor)

          output.puts visitor.root.to_str('', options)

          if options[:show_report]
            output.puts
            output.puts "#{visitor.nr_directories} directories, #{visitor.nr_files} files"
          end

        when 'print-dir'
          visitor = PrintDirTreeVisitor.new
          directory_tree_walker.run(visitor)

        when 'yaml'
          visitor = DirectoryToHashVisitor.new(dirname)
          root    = directory_tree_walker.run(visitor).root
          output.puts root.to_yaml

        when 'json'
          visitor = DirectoryToHashVisitor.new(dirname)
          root    = directory_tree_walker.run(visitor).root
          begin
            output.puts JSON.pretty_generate(root)
          rescue JSON::NestingError => e
            $stderr.puts "#{File.basename(__FILE__)}:#{__LINE__} #{e.to_s}"
          end

        when 'd3js'
          require 'tree_rb/output_html/d3js_helper'
          D3jsHelper.new.run(directory_tree_walker, dirname, nil, output)

        when 'html_partition'
          require 'tree_rb/output_html/d3js_helper'
          D3jsHelper.new.run(directory_tree_walker, dirname, "d3js_layout_partition.erb", output)

        when 'html_tree'
          require 'tree_rb/output_html/d3js_helper'
          D3jsHelper.new.run(directory_tree_walker, dirname, "d3js_layout_tree.erb", output)

        when 'html_treemap'
          require 'tree_rb/output_html/d3js_helper'
          D3jsHelper.new.run(directory_tree_walker, dirname, "d3js_layout_treemap.erb", output)

        when 'sqlite'
          require 'tree_rb/output_sqlite/sqlite_helper'
          SqliteHelper.new.run(directory_tree_walker, output, options)

        when 'dircat'
          require 'tree_rb/output_dircat/dircat_helper'
          DirCatHelper.new.run(directory_tree_walker, options)

        else
          puts "unknown format #{options[:format]} specified"
      end

      0
    end

  end # end class
end # end module
