# -*- coding: utf-8 -*-
cwd = File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 'lib') )
$:.unshift(cwd) unless $:.include?(cwd)
require 'tree_rb'
include TreeRb

root_dir =  '..'

puts '*** print all files excluding "*.git" and "*.ini"'
dtw = DirTreeWalker.new( :ignore => %w(.git .ini) )
dtw.run root_dir do
  on_leaf do |pathname|
    puts "- #{pathname}"
  end
end

puts '*** print files with extension *.sh" and "*.js"'
dtw = DirTreeWalker.new( :match => /.sh/ )
dtw.run root_dir do
  on_leaf do |pathname|
    puts "- #{pathname}"
  end
end
