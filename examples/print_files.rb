# -*- coding: utf-8 -*-
cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)

require 'treevisitor'
include TreeVisitor

class MyVisitor < TreeNodeVisitor
  def visit_leaf_node( pathname )
    puts pathname
  end
end

dtw = DirTreeWalker.new( ".." )
dtw.ignore ".git"
dtw.run( MyVisitor.new )
