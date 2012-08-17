# -*- coding: utf-8 -*-
module TreeRb

  #
  # contains informataion related to directory (TreeNode)
  #
  class ContentDir
    def initialize( basename, options )
      @basename = basename
      @options = options
    end
    def to_str
      @basename
    end
  end

  #
  # contains information related to file (LeafNode)
  #
  class ContentFile
    def initialize( pathname, options )
      stat = File.lstat(pathname)
      # stat.symlink?

      if options[:show_size]
        str  = "#{File.basename(pathname)} #{stat.size}"
      elsif options[:show_size_human]
        str  = "#{File.basename(pathname)} #{stat.size.to_human}"
      else
        str  = "#{File.basename(pathname)}"
      end
    
      if options[:show_md5]
        str << " #{MD5.file( pathname ).hexdigest}"
      end
      @str = str

    end
    def to_str
      @str
    end
  end

  #
  # Builds a TreeNode from a filesystem directory
  # It similar to CloneTreeNodeVisitor
  #
  class BuildDirTreeVisitor 

    attr_reader :root

    #
    # Number of visited directory (aka nr_nodes - nr_leaf)
    #
    attr_reader :nr_directories

    #
    # Number of visited directory (nr_leaves)
    # @see AbsNode#nr_leaves
    #
    attr_reader :nr_files
    
    def initialize(options = {})
      @root = nil
      @stack = []
      @nr_directories = 0
      @nr_files = 0
      @options = options
    end

    def enter_node( pathname )
      content = ContentDir.new(File.basename( pathname ), @options)
      if @stack.empty?
        tree_node = TreeNode.new( content )
        @root = tree_node
      else
        tree_node = TreeNode.new( content, @stack.last )
      end
      @nr_directories += 1
      @stack.push( tree_node )
    end

    def cannot_enter_node(pathname, error)
    end

    def exit_node( pathname )
      @stack.pop
    end

    def visit_leaf( pathname )
      content = ContentFile.new(pathname, @options)
      # connect the leaf_node created to the last tree_node on the stack
      @nr_files  += 1
      LeafNode.new( content, @stack.last )
    end

  end
end # end module TreeVisitor
