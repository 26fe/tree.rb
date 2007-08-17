
require 'rubygems'   # if installed with 'gem install'
require 'abstract'

  class Foo
    abstract_method 'arg1, arg2=""', :method1, :method2, :method3
  end

class DirTreeProcessor

  def initialize( dirname )
    @dirname = dirname
    @ignore_dir_patterns = []
    @ignore_file_patterns = []
  end

  def run
    process_directory( @dirname )
  end

  def add_ignore_dir( pattern )
    @ignore_dir_patterns << pattern
  end

  def add_ignore_file( pattern )
    @ignore_file_patterns << pattern
  end

  def ignore_dir?( dirname )
    basename = File.basename( dirname )
    @ignore_dir_patterns.find{ |pattern|
      basename == pattern
    }
  end

  def ignore_file?( filename )
    basename = File.basename( filename )
    @ignore_file_patterns.find{ |pattern|
      basename == pattern
    }
  end

  protected

  # processa un file (path completo)
  # il valore di ritorno potrebbe essere utilizzato da ...
  # metodo astratto
  #
  def visit_file( filename )
    not_implemented
  end

  def visited_file( dirname )
    not_implemented
  end

  def visit_dir( dirname )
    not_implemented
  end

  def visited_dir( filename )
    not_implemented
  end

  private

  #
  # recurse on other directories
  #
  def process_directory( dirname )
    return nil if ignore_dir?( dirname )

    # puts dirname
    treeNode = visit_dir( dirname )

    Dir.entries( dirname ).each { |basename|
      next if basename == "." or basename == ".."
      next if ignore_dir?( basename )
      pathname = dirname + File::Separator + basename
      if File.directory?( pathname )
        ret = process_directory( pathname )
        if ! treeNode.nil? && ! ret.nil?
          visited_dir( treeNode, ret )
        end
      else
        if ! ignore_file?( basename )
          ret = visit_file( pathname )
          if ! treeNode.nil? && ! ret.nil?
            visited_file( treeNode, ret )
          end
        end
      end
    }
    treeNode
  end
end

