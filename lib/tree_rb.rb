# -*- coding: utf-8 -*-

#
# std lib
#
require 'pathname'
require 'yaml'

#
# rubygems
#
# require 'rubygems' # rubygems must be loaded from binary file (tree.rb) so $LOAD_PATH is not modified
require 'json'
require 'ansi/code'
begin
  require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/
rescue LoadError
  puts 'You must gem install win32console to use color on Windows'
end

#
# treevisitor
#

require 'tree_rb/version'
require 'tree_rb/extension_digest'
require 'tree_rb/extension_numeric'

require 'tree_rb/abs_node'
require 'tree_rb/leaf_node'
require 'tree_rb/tree_node'
require 'tree_rb/basic_tree_node_visitor'
require 'tree_rb/tree_node_visitor'

require 'tree_rb/directory_walker'

#
# visitors
#
#require 'tree_rb/visitors/block_tree_node_visitor'
#require 'tree_rb/visitors/build_dir_tree_visitor'
#require 'tree_rb/visitors/callback_tree_node_visitor2'
#require 'tree_rb/visitors/clone_tree_node_visitor'
#require 'tree_rb/visitors/depth_tree_node_visitor'
#require 'tree_rb/visitors/print_dir_tree_visitor'
#require 'tree_rb/visitors/directory_to_hash_visitor'
#require 'tree_rb/visitors/sqlite_dir_tree_visitor'

visitors_dir = File.join(File.dirname(__FILE__), "tree_rb", "visitors")
unless Dir.exist? visitors_dir
  raise "cannot found directory '#{visitors_dir}'"
end
Dir[ File.join(visitors_dir, "*.rb") ].each { |f|require f }


require 'tree_rb/util/dir_processor'
