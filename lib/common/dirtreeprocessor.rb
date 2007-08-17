class DirTreeProcessor

  def initialize( dirname )
    @dirname = dirname
  end

  def run
    process_directory( @dirname )
  end

  private

  def process_file( filename )
    puts filename
    filename
  end

  #
  # recurse on other directories
  #
  def process_directory( dirname )

    puts dirname
    treeNode = TreeNode.new( dirname )

    Dir.entries( dirname ).each { |basename|
      next if basename == "." or basename == ".."
      # next if $config.ignore_dir( filename )
      pathname = dirname + File::Separator + basename
      if File.directory?( pathname )
        ret = process_directory( pathname )
        treeNode.add_child( ret )
      else
        ret = process_file( pathname )
        treeNode.add_value( ret )
      end
    }

    treeNode
  end
end