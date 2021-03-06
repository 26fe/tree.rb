# -*- coding: utf-8 -*-

require 'rubygems'

cwd = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib"))
$:.unshift(cwd) unless $:.include?(cwd)
require 'treevisitor'
include TreeRb

#
# convert a directory tree into a json
#
dir = File.expand_path( File.join('..', '..', 'lib') )

dtw = TreeRb::DirTreeWalker.new( :ignore => [/^\./, 'doc', 'pkg'] )
root = dtw.run(dir, DirectoryToHashVisitor.new(dir)).root

str =  "var treevisitor = #{JSON.pretty_generate(root)};"
File.open(File.dirname(__FILE__) + '/treevisitor.js', 'w'){ |f| f.write str }
