

#
# Utilizzo della classa astratta DirTreeProcessor
# per visitare un albero di directory
#
class VisitDirTreeProcessor < DirTreeProcessor

  def initialize( *args )
    super( *args )
    @depth = 0
  end

  protected

  def visit_file( treeNode, pathname )
    str = ""
    (0...@depth-1).step {
      str << " |-"
    }
    str << " |  "
    puts str + File.basename( pathname )
  end

  def visited_file( treeNode, nodeItem )
  end

  def visit_dir( parentNode, dirname )

    str = ""
    (0...@depth).step {
      str << " |-"
    }

    if @depth == 0
      puts str + dirname
    else
      puts str + File.basename( dirname )
    end
    @depth += 1
  end

  def visited_dir( parentNode, childNode )
    @depth -= 1
  end


end