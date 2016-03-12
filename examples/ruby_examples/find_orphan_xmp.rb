# -*- coding: utf-8 -*-

# tree.rb
cwd = File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 'lib') )
$:.unshift(cwd) unless $:.include?(cwd)
require 'tree_rb'
include TreeRb


root_dir =  File.expand_path( File.join( cwd, '..', 'spec', 'fixtures', 'test_orphaned_xmp' ) )

puts "*** print all xmp files starting from '#{root_dir}'"

dtw = DirTreeWalker.new( :match => /.xmp/ )
dtw.run root_dir do
  on_leaf do |pathname|
    puts "- #{pathname}"
  end

  # on_enter_node

end
