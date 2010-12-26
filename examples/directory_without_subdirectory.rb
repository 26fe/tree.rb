cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)
require 'treevisitor'

require 'ostruct'
#
# Find directory without subdirectories
#
class DirWithoutSubDir < TreeVisitor::TreeNodeVisitor

  def initialize
    super
    @stack = []
    @nr = 0
  end

  def enter_tree_node( pathname )
    @nr += 1
    info = OpenStruct.new(:nr => @nr, :pathname => pathname)
    @stack.push( info )
  end

  def exit_tree_node( pathname )
    info = @stack.pop
    if info.nr == @nr
      puts "leaf: #{pathname}"
    end
  end

end

dtw = TreeVisitor::DirTreeWalker.new( ".." )
dtw.ignore /^\./
dtw.visit_file=false
dtw.run( DirWithoutSubDir.new )
