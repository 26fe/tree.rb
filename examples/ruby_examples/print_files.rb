# -*- coding: utf-8 -*-
cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)
require 'tree_rb'
include TreeRb

dtw = DirTreeWalker.new( :ignore => %w(.git .ini) )

dir =  '..'
dtw.run dir do
  on_leaf do |pathname|
    puts "- #{pathname}"
  end
end
