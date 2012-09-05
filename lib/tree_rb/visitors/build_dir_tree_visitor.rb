# -*- coding: utf-8 -*-
module TreeRb

  #
  # contains information related to directory (TreeNode)
  #
  class ContentDir
    def initialize(pathname, options)
      if options[:show_full_path]
        @contents = pathname
      else
        @contents = File.basename(pathname)
      end
    end

    def to_str
      @contents
    end
  end

  #
  # contains information related to file (LeafNode)
  #
  class ContentFile
    def initialize(pathname, options)
      stat = File.lstat(pathname)
      # stat.symlink?

      if options[:show_full_path]
        file_name = pathname
      else
        file_name = File.basename(pathname)
      end

      if options[:show_md5sum]
        @str = "#{MD5.file(pathname).hexdigest}  #{file_name}"
        return
      end
      if options[:show_sha1sum]
        @str = "#{SHA1.file(pathname).hexdigest}  #{file_name}"
        return
      end

      if options[:show_size]
        str = "#{file_name} #{stat.size}"
      elsif options[:show_size_human]
        str = "#{file_name} #{stat.size.to_human}"
      else
        str = "#{file_name}"
      end

      if options[:show_md5]
        str << " md5: #{MD5.file(pathname).hexdigest}"
      end

      if options[:show_sha1]
        str << " sha1: #{SHA1.file(pathname).hexdigest}"
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

    def initialize(options = { })
      @root           = nil
      @stack          = []
      @nr_directories = 0
      @nr_files       = 0
      @options        = options
    end

    def enter_node(pathname)
      content = ContentDir.new(pathname, @options)
      if @stack.empty?
        tree_node = TreeNode.new(content)
        @root     = tree_node
      else
        tree_node = TreeNode.new(content, @stack.last)
      end
      @nr_directories += 1
      @stack.push(tree_node)
    end

    def cannot_enter_node(pathname, error)
    end

    def exit_node(pathname)
      @stack.pop
    end

    def visit_leaf(pathname)
      content   = ContentFile.new(pathname, @options)
      # connect the leaf_node created to the last tree_node on the stack
      @nr_files += 1
      LeafNode.new(content, @stack.last)
    end

  end
end # end module TreeVisitor
