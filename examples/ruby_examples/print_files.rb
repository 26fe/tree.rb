# -*- coding: utf-8 -*-
cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)
require 'tree_rb'
include TreeRb

dtw = DirTreeWalker.new( :ignore => ".git" )
dtw.run ".." do
  on_leaf do |pathname|
    puts "- #{pathname}"
  end
end
