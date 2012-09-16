# -*- coding: utf-8 -*-

cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)
require 'tree_rb'
include TreeRb

class MyVisitor < BasicTreeNodeVisitor
  def visit_leaf( pathname )
    puts "found: #{pathname}"
  end
end

dtw = DirTreeWalker.new( File.join(File.dirname(__FILE__), "..", ".." ) )
dtw.match "leaf_node.rb"
dtw.match "abs_node.rb"
dtw.run( MyVisitor.new )

