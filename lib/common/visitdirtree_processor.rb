
class PrintDirTreeVisitor < DirTreeVisitor

  def initialize( *args )
    super( *args )
    @depth = 0
  end

  def visit_file( treeNode, pathname )
    str = ""
    (0...@depth-1).step {
      str << " |-"
    }
    str << " |  "
    puts str + File.basename( pathname )
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

#
# Utilizzo della classa astratta DirTreeProcessor
# per visitare un albero di directory
#
class VisitDirTreeProcessor < DirTreeWalker
  def run
    super( PrintDirTreeVisitor.new )
  end
end