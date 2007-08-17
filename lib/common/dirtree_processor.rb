
require 'rubygems'   # if installed with 'gem install'
require 'abstract'

  class Foo
    abstract_method 'arg1, arg2=""', :method1, :method2, :method3
  end

class DirTreeProcessor

  def initialize( dirname )
    @dirname = dirname

    @ignore_dir_patterns = []
    @inspect_file_patterns = []
    @ignore_file_patterns = []
  end

  def run
    process_directory( nil, @dirname )
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

  def ignore_dir?( dirname )
    basename = File.basename( dirname )
    @ignore_dir_patterns.find{ |pattern|
      basename == pattern
    }
  end

  def ignore_file?( filename )
    basename = File.basename( filename )
    @ignore_file_patterns.find{ |pattern|
      if pattern.kind_of? Regexp
        pattern =~ basename
      else
        pattern == basename
      end
    }
  end

  def inspect_file?( filename )
    return true if @inspect_file_patterns.empty?
    basename = File.basename( filename )
    @inspect_file_patterns.find{ |pattern|
      if pattern.kind_of? Regexp
        pattern =~ basename
      else
        pattern == basename
      end
    }
  end

  protected

  # processa un file (path completo)
  # il valore di ritorno potrebbe essere utilizzato da ...
  # metodo astratto
  #
  def visit_file( treeNode, filename )
    not_implemented
  end

  def visited_file( treeNode, dirname )
    not_implemented
  end

  def visit_dir( treeNode, dirname )
    not_implemented
  end

  def visited_dir( treeNode, filename )
    not_implemented
  end

  private

  #
  # recurse on other directories
  #
  def process_directory( parentNode, dirname )
    return nil if ignore_dir?( dirname )

    # puts dirname
    treeNode = visit_dir( parentNode, dirname )

    Dir.entries( dirname ).each { |basename|
      next if basename == "." or basename == ".."
      pathname = dirname + File::Separator + basename

      if File.directory?( pathname )

        # directory
        if ! ignore_dir?( basename )
          ret = process_directory( treeNode, pathname )
          if ! treeNode.nil? && ! ret.nil?
            visited_dir( treeNode, ret )
          end
        end

      else

        # file
        if inspect_file?( basename ) && ! ignore_file?( basename )
          ret = visit_file( treeNode, pathname )
          if ! treeNode.nil? && ! ret.nil?
            visited_file( treeNode, ret )
          end
        end

      end
    }
    treeNode
  end
end
