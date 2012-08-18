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

      options = { :verbose => true, :force => false, :algo => 'build-dir' }

      opts        = OptionParser.new
      opts.banner = "Usage: tree.rb [options] [directory]"
      opts.separator "list contents of directories in a tree-like format"
      opts.separator "this is a almost :-) a clone of tree unix command written in ruby"
      opts.separator "Code https://github.com/tokiro/treevisitor. Feedback to tokiro.oyama@gmail.com"

      opts.separator ""
      opts.separator "options: "

      opts.on("--help", "Show this message") do
        puts opts
        return 0
      end

      opts.on("--version", "Show the version") do
        puts "tree.rb version #{TreeRb::VERSION}"
        return 0
      end

      opts.on("-a", "All file are listed i.e. include dot files") do
        options[:all_files] = true
      end

      opts.on("-d", "List directories only") do
        options[:only_directories] = true
      end

      options[:only_files] = false
      opts.on("--only-files", "show only file implies -i") do
        options[:only_files]       = true
        options[:show_indentation] = false
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      opts.on("-q", "--quiet", "quiet mode as --no-verbose") do
        options[:verbose] = false
      end

      algos        = %w[build-dir print-dir json yaml]
      algo_aliases = { "b" => "build-dir", "v" => "print-dir", "j" => "json", "y" => "yaml" }

      algo_list = (algo_aliases.keys + algos).join(',')
      opts.on("--format ALGO", algos, algo_aliases, "select an algo", "  (#{algo_list})") do |algo|
        options[:algo] = algo
      end

      options[:show_full_path] = false
      opts.on("-f", "Prints the full path prefix for each file.") do
        options[:show_full_path] = true
      end

      #
      # begin colorize
      #
      # copied from tree man page
      opts.on("-n", "Turn colorization off always, over-ridden by the -C option.") do
        options[:colorize] = false
      end

      # copied from tree man page
      opts.on("-C", "Turn colorization on always, using built-in color defaults if the LS_COLORS environment variable is not set.  Useful to colorize output to a pipe.") do
        options[:colorize] = true
      end
      options[:colorize] ||= $stdout.isatty

      #
      # end colorize
      #

      opts.on("-s", "Print the size of each file in bytes along with the name.") do
        options[:show_size] = true
      end

      msg =<<-EOS
       Print the size of each file but in a more human readable way, e.g. appending  a  size  letter  for  kilobytes  (K),
              megabytes (M), gigabytes (G), terrabytes (T), petabytes (P) and exabytes (E).
      EOS

      opts.on("-h", msg) do
        options[:show_size_human] = true
      end

      options[:show_indentation] = true
      opts.on("-i", "Makes tree not print the indentation lines, useful when used in conjunction with the -f option.") do
        options[:show_indentation] = false
      end

      options[:show_md5] = false
      opts.on("--md5", "show md5 of file") do
        options[:show_md5] = true
      end

      options[:show_sha1] = false
      opts.on("--sha1", "show sha1 of a file") do
        options[:show_sha1] = true
      end

      options[:show_md5sum] = false
      opts.on("--md5sum", "show ake md5sum implies -i and --only-files") do
        options[:only_files]       = true
        options[:show_md5sum]      = true
        options[:show_indentation] = false
      end

      begin
        rest = opts.parse(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.to_s
        $stderr.puts "try -h for help"
        return false
      rescue OptionParser::MissingArgument => e
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

      dtw = DirTreeWalker.new(dirname)
      unless options[:all_files]
        dtw.ignore(/^\.[^.]+/) # ignore all file starting with "."
      end

      dtw.visit_file = !options[:only_directories]

      case options[:algo]

        when 'build-dir'
          # TODO: capture CTRL^C to avoid show the stack trace
          # http://ruby-doc.org/core-1.9.3/Kernel.html#method-i-trap
          Signal.trap('INT') { put "User interrupted exit"; exit }

          visitor = BuildDirTreeVisitor.new(options)
          dtw.run(visitor)

          puts visitor.root.to_str('', options)
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
