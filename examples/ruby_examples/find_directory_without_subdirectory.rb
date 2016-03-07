# -*- coding: utf-8 -*-
require 'ostruct'

cwd = File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 'lib') )
$:.unshift(cwd) unless $:.include?(cwd)
require 'tree_rb'

#
# Find directories without subdirectories
#
class DirWithoutSubDir < TreeRb::BasicTreeNodeVisitor

  def initialize
    super
    @stack = []
    @nr = 0
  end

  def enter_node( pathname )
    @nr += 1
    info = OpenStruct.new(:nr => @nr, :pathname => pathname)
    @stack.push( info )
  end

  def exit_node( pathname )
    info = @stack.pop
    if info.nr == @nr
      puts "leaf: #{pathname} with no subdir"
    end
  end

end

dtw = TreeRb::DirTreeWalker.new( File.join('..', '..') )
dtw.ignore /^\./
dtw.visit_file=false
dtw.run( DirWithoutSubDir.new )
