# -*- coding: utf-8 -*-
module TreeRb

  #
  #
  #
  class CliJson

    SUCCESS=0
    FAILURE=1

    def self.run
      self.new.parse_args(ARGV)
    end

    def options_parser(options)
      parser        = OptionParser.new
      parser.banner = "Usage: rjson.rb [options] [directory]"
      parser.separator 'pretty format json file'
      parser.separator 'Code https://github.com/tokiro/treevisitor. Feedback to tokiro.oyama@gmail.com'

      parser.on('-o [FILE]', "--output [FILE]", String) do |v|
        if options[:output]
          puts 'only one file of output can be used'
          options[:exit] = true
        end
        options[:output] = v
      end

      options[:force_overwrite_output] = false
      parser.on("--force", "overwrite output") do
        options[:force_overwrite_output] = true
      end
      parser.on_tail('--help', 'Show this message') do
        puts parser
        options[:exit] = SUCCESS
      end

      parser.on_tail("--version", "Show the version") do
        puts "tree.rb version #{TreeRb::VERSION}"
        options[:exit] = SUCCESS
      end

      parser
    end

    def parse_args(argv)
      options = { :verbose => true, :force => false, :output_plugins => 'build-dir' }
      parser  = options_parser(options)

      begin
        rest = parser.parse(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.to_s
        $stderr.puts "try --help for help"
        return FAILURE
      rescue OptionParser::MissingArgument => e
        $stderr.puts e.to_s
        $stderr.puts "try --help for help"
        return FAILURE
      end

      unless options[:exit].nil?
        return options[:exit]
      end

      ##
      ## option: output, force
      ##
      output = $stdout
      if options[:output]
        filename = options[:output]
        if File.exist?(filename) and not options[:force_overwrite_output]
          $stderr.puts "catalog '#{filename}' exists use --force to overwrite"
          return FAILURE
        end
        output = File.open(filename, "w")
        $stderr.puts "Writing file '#{filename}'"
      end

      if rest.length < 1
        $stderr.puts 'missing arg'
        return FAILURE
      else
        filename = rest[0]
      end

      show_input = false

      unless File.exists?(filename)
        $stderr.puts "input file not exists '#{filename}'"
        exit
      end

      my_json_str = File.read(filename)

      if show_input
        $stderr.puts '*************************'
        $stderr.puts my_json_str
        $stderr.puts '*************************'
      end

      begin
        my_json = JSON(my_json_str)
      rescue JSON::ParserError
        $stderr.puts 'json is malformed'
        return FAILURE
      end

      output.puts JSON.pretty_generate(my_json)

      SUCCESS
    end

  end # end class
end # end module
