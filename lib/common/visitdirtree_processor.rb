
class PrintDirTreeVisitor < TreeNodeVisitor

  def initialize( *args )
    super( *args )
    @depth = 0
  end

  def visit_leafNode( pathname )
    str = ""
    (0...@depth-1).step {
      str << " |-"
    }
    str << " |  "
    puts str + File.basename( pathname )
  end

  def enter_dir( dirname )

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

  def exit_dir( parentNode )
    @depth -= 1
  end
end

