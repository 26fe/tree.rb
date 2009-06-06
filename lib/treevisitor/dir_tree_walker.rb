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

    @inspect_file_patterns = []

    #
    # options
    #
    @visit_leaf = true
  end

  ##########################################################################
  # Pattern
  #
  def add_ignore_pattern(pattern)
    @ignore_dir_patterns << pattern
    @ignore_file_patterns << pattern
  end

  def add_ignore_dir( pattern )
    @ignore_dir_patterns << pattern
  end

  def add_ignore_file( pattern )
    @ignore_file_patterns << pattern
  end

  #
  # quali file bisogna prendere in considerazione
  # inspect opposto di ignore :-)
  #
  def add_inspect_file( pattern )
    @inspect_file_patterns << pattern
  end

  ##########################################################################
  # Options
  
  attr_accessor :visit_leaf

  ##########################################################################


  def ignore_dir?( dirname )
    include?( @ignore_dir_patterns, File.basename( dirname ) )
  end

  def ignore_file?( filename )
    include?( @ignore_file_patterns, File.basename( filename ) )
  end

  def inspect_file?( filename )
    return true if @inspect_file_patterns.empty?
    include?( @inspect_file_patterns, File.basename( filename ) )
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

  def include?(patterns, basename)
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

    Dir.entries( dirname ).each { |basename|
      next if basename == "." or basename == ".."  # ignore always "." and ".."
      pathname = File.join( dirname, basename )

      if File.directory?( pathname )
        # directory
        process_directory( pathname ) unless ignore_dir?( basename )
      else
        if @visit_leaf
          if inspect_file?( basename ) && ! ignore_file?( basename )
            @visitor.visit_leaf_node( pathname )
          end
        end
      end
    }
    @visitor.exit_tree_node( dirname )
  end
end
