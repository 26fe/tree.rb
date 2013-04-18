# -*- coding: utf-8 -*-
module TreeRb

  #
  # Visit a file system directory
  #
  class DirTreeWalker

    # Build a tree walker.
    # Visit a director starting from dirname
    # if dirname is missing, must be supplied when invoking run
    #
    # @yield [a, b, c] TreeNodeVisitor
    # @yieldparam [optional, types, ...] argname description
    # @yieldreturn [optional, types, ...] description
    #
    # @overload initialize(dirname)
    #   @param [String] dirname the root of the tree (top level directory)
    #
    # @overload initialize(dirname, options)
    #   @param [Hash] options
    #   @option options [String,Regex, Array<String,Regexp>] :ignore list of ignore pattern
    #   @option options [String] :ignore_dir
    #   @option options [String] :ignore_file
    #   @option options [String] :match
    #
    #
    # @example Print the contents of tmp directory
    #   DirTreeWalker.new("/tmp") do
    #     on_visit_leaf_node { |pathname| puts pathname }
    #   end.run
    #
    def initialize(dirname = nil, options = nil)
      #
      # arg detection
      #
      if dirname and dirname.respond_to?(:key?)
        options = dirname
        dirname = nil
      end

      if dirname
        @dirname = dirname
        unless File.directory?(dirname)
          raise ArgumentError.new "#{dirname} is not a directory!"
        end
      end

      @visitor              = nil

      #
      # pattern
      #
      @ignore_dir_patterns  = []
      @ignore_file_patterns = []
      @match_file_patterns  = []

      if options and options[:ignore]
        unless options[:ignore].respond_to?(:at)
          options[:ignore] = [options[:ignore]]
        end
        options[:ignore].each { |p| ignore(p) }
      end

      if options and options[:ignore_dir]
        unless options[:ignore_dir].respond_to?(:at)
          options[:ignore_dir] = [options[:ignore_dir]]
        end
        options[:ignore_dir].each { |p| ignore_dir(p) }
      end

      if options and options[:ignore_file]
        unless options[:ignore_file].respond_to?(:at)
          options[:ignore_file] = [options[:ignore_file]]
        end
        options[:ignore_file].each { |p| ignore_file(p) }
      end

      if options and options[:match]
        unless options[:match].respond_to?(:at)
          options[:match] = [options[:match]]
        end
        options[:match].each { |p| match(p) }
      end

      #
      # options
      #
      @visit_file = true

      @max_level = nil
      if options and options[:max_level]
        @max_level = options[:max_level]
      end
    end

    ##########################################################################
    # Pattern

    #
    # Ignore a node (leaf/Tree) matching pattern
    # @param [RegEx] pattern
    #
    def ignore(pattern)
      @ignore_dir_patterns << pattern
      @ignore_file_patterns << pattern
      self
    end

    #
    # Ignore a directory (Tree) matching pattern
    # @param [RegEx] pattern
    #
    def ignore_dir(pattern)
      @ignore_dir_patterns << pattern
      self
    end

    #
    # Ignore a file (Leaf) matching pattern
    # @param [RegEx] pattern
    #
    def ignore_file(pattern)
      @ignore_file_patterns << pattern
      self
    end

    #
    # Just the opposite of ignore
    # directory/file matching pattern will be visited
    #
    # @param [RegEx] pattern
    #
    def match(pattern)
      @match_file_patterns << pattern
      self
    end

    ##########################################################################
    # Options

    #
    # it is true to visit file
    #
    attr_accessor :visit_file

    ##########################################################################

    #
    # Test directory ignore pattern
    #
    # @param [String] dirname directory name
    # @return [boolean] if dirname match almost one pattern
    #
    def ignore_dir?(dirname)
      _include?(@ignore_dir_patterns, File.basename(dirname))
    end

    #
    # Test file ignore pattern
    #
    # @param [String] filename
    # @return [boolean] if filename match almost one pattern
    #
    def ignore_file?(filename)
      _include?(@ignore_file_patterns, File.basename(filename))
    end

    #
    # Test common ignore pattern
    #
    # @param [String] filename
    # @return [boolean] if filename match almost one pattern
    #
    def match?(filename)
      return true if @match_file_patterns.empty?
      _include?(@match_file_patterns, File.basename(filename))
    end

    #
    # Run the visitor through the directory tree
    #
    # @overload run
    #
    # @overload run(dirname)
    #   @param [String] dirname
    #   @yield define TreeNodeVisitor
    #
    # @overload run(tree_node_visitor)
    #   @param [TreeNodeVisitor]
    #   @yield define TreeNodeVisitor
    #
    # @overload run(dirname, tree_node_visitor)
    #   @param [String] dirname
    #   @param [TreeNodeVisitor]
    #   @yield define TreeNodeVisitor
    #
    # @return [TreeNodeVisitor] the visitor
    #
    # @example Print the contents of tmp directory
    #   w = DirTreeWalker.new
    #   w.run("/tmp") do
    #     on_visit_leaf_node { |pathname| puts pathname }
    #   end.run
    #
    def run(dirname = nil, tree_node_visitor = nil, &block)

      #
      # args detection
      #
      if dirname and dirname.respond_to?(:enter_node)
        tree_node_visitor = dirname
        dirname           = nil
      end

      #
      # check dirname
      #
      if @dirname.nil? and dirname.nil?
        raise 'missing starting directory'
      end
      @dirname = dirname if dirname

      #
      # check visitor
      #
      if tree_node_visitor and block
        raise 'cannot use block and parameter together'
      end

      if tree_node_visitor
        @visitor = tree_node_visitor
      end

      if block
        @visitor = TreeNodeVisitor.new(&block)
      end

      unless @visitor
        raise "missing visitor"
      end

      #
      # finally starts to process
      #
      process_directory(File.expand_path(@dirname))
      @visitor
    end

    private

    def _include?(patterns, basename)
      # return false if the patters.empty?
      patterns.find { |pattern|
        if pattern.kind_of? Regexp
          pattern.match(basename)
        else
          basename == pattern
        end
      }
    end

    #
    # recurse on other directories
    #
    def process_directory(dirname, level=1)
      begin
        entries = Dir.entries(dirname).sort
      rescue Errno::EACCES => e
        $stderr.puts e
        @visitor.cannot_enter_node(dirname, e)
        return
      rescue Errno::EPERM => e
        $stderr.puts e
        @visitor.cannot_enter_node(dirname, e)
        return
      rescue Errno::ENOENT => e
        $stderr.puts e
        @visitor.cannot_enter_node(dirname, e)
        return
      end


      @visitor.enter_node(dirname)
      entries.each do |basename|
        begin
          next if basename == "." or basename == ".." # ignore always "." and ".."
          pathname = File.join(dirname, basename)

          if File.directory?(pathname)
            if not ignore_dir?(basename) and (@max_level.nil? or @max_level > level)
              process_directory(pathname, level+1)
            end
          else
            if !!@visit_file && match?(basename) && !ignore_file?(basename)
              @visitor.visit_leaf(pathname)
            end
          end
        rescue Errno::EACCES => e
          $stderr.puts e
        rescue Errno::EPERM => e
          $stderr.puts e
        rescue Errno::ENOENT => e
          $stderr.puts e
        end
      end

      @visitor.exit_node(dirname)
    end
  end
end
