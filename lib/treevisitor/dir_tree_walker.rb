# -*- coding: utf-8 -*-
module TreeVisitor
  class DirTreeWalker

    def initialize( dirname )
      @dirname = dirname
      unless File.directory?( dirname )
        raise "#{dirname} is not a directory!"
      end

      @visitor = nil

      #
      # pattern
      #
      @ignore_dir_patterns = []
      @ignore_file_patterns = []

      @match_file_patterns = []

      #
      # options
      #
      @visit_leaf = true
    end

    ##########################################################################
    # Pattern
    #
    def ignore(pattern)
      @ignore_dir_patterns << pattern
      @ignore_file_patterns << pattern
    end

    def ignore_dir( pattern )
      @ignore_dir_patterns << pattern
    end

    def ignore_file( pattern )
      @ignore_file_patterns << pattern
    end

    #
    # quali file bisogna prendere in considerazione
    # match opposto di ignore :-)
    #
    def match( pattern )
      @match_file_patterns << pattern
    end

    ##########################################################################
    # Options
  
    attr_accessor :visit_leaf

    ##########################################################################


    def ignore_dir?( dirname )
      _include?( @ignore_dir_patterns, File.basename( dirname ) )
    end

    def ignore_file?( filename )
      _include?( @ignore_file_patterns, File.basename( filename ) )
    end

    def match?( filename )
      return true if @match_file_patterns.empty?
      _include?( @match_file_patterns, File.basename( filename ) )
    end

    #
    # return the visitor
    #
    def run( tree_node_visitor )
      @visitor = tree_node_visitor
      process_directory( File.expand_path( @dirname ) )
      tree_node_visitor
    end

    private

    def _include?(patterns, basename)
      # return false if the patters.empty?
      patterns.find{ |pattern|
        if pattern.respond_to?(:match) # or if pattern.kind_of? Regexp
          pattern.match( basename )
        else
          basename == pattern
        end
      }
    end

    #
    # recurse on other directories
    #
    def process_directory( dirname )
      @visitor.enter_tree_node( dirname )
      # return if ignore_dir?( dirname )

      Dir.entries( dirname ).sort.each { |basename|
        next if basename == "." or basename == ".."  # ignore always "." and ".."
        pathname = File.join( dirname, basename )

        if File.directory?( pathname )
          # directory
          process_directory( pathname ) unless ignore_dir?( basename )
        else
          if @visit_leaf
            if match?( basename ) && ! ignore_file?( basename )
              @visitor.visit_leaf_node( pathname )
            end
          end
        end
      }
      @visitor.exit_tree_node( dirname )
    end
  end
end
