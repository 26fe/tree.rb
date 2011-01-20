# -*- coding: utf-8 -*-
module TreeVisitor

  #
  # Visit a file system directory
  #
  class DirTreeWalker

    #
    # @param [String] dirname the root of the tree (top level directory)
    #                 if dirname is missing, must be supplied when invoking run
    # @param [Hash] options
    # @option opts [Array] :ignore list of ignore pattern
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
          raise "#{dirname} is not a directory!"
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
          options[:ignore] = [ options[:ignore] ]
        end
        options[:ignore].each { |p| ignore(p) }
      end

      #
      # options
      #
      @visit_file           = true
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
    # @param [String] directory name
    # @return [boolean] if dirname match almost one pattern
    #
    def ignore_dir?(dirname)
      _include?(@ignore_dir_patterns, File.basename(dirname))
    end

    #
    # Test file ignore pattern
    #
    # @param [String] file name
    # @return [boolean] if filename match almost one pattern
    #
    def ignore_file?(filename)
      _include?(@ignore_file_patterns, File.basename(filename))
    end

    #
    # Test common ignore pattern
    #
    # @param [String] file name
    # @return [boolean] if filename match almost one pattern
    #
    def match?(filename)
      return true if @match_file_patterns.empty?
      _include?(@match_file_patterns, File.basename(filename))
    end

    #
    # Run the visitor through the directory tree
    #
    # @param [TreeNodeVisitor]
    # @param [String] dirname
    # @return [TreeNodeVisitor] the visitor
    #
    def run(dirname = nil, tree_node_visitor = nil, &block)

      #
      # args detection
      #
      if dirname and dirname.respond_to?(:enter_tree_node)
        tree_node_visitor = dirname
        dirname = nil
      end

      #
      # check dirname
      #
      if @dirname.nil? and dirname.nil?
        raise "missing starting directory"
      end
      @dirname = dirname if dirname

      #
      # check visitor
      #
      if tree_node_visitor and block
        raise "cannot use block and parameter together"
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
    def process_directory(dirname)
      @visitor.enter_tree_node(dirname)
      # return if ignore_dir?( dirname )

      Dir.entries(dirname).sort.each { |basename|
        next if basename == "." or basename == ".." # ignore always "." and ".."
        pathname = File.join(dirname, basename)

        if File.directory?(pathname)
          process_directory(pathname) unless ignore_dir?(basename)
        else
          if !!@visit_file && match?(basename) && !ignore_file?(basename)
            @visitor.visit_leaf_node(pathname)
          end
        end
      }
      @visitor.exit_tree_node(dirname)
    end
  end
end
