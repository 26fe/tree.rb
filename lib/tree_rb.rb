# -*- coding: utf-8 -*-

#
# std lib
#
require 'pathname'
require 'yaml'
require 'ostruct'
require 'nokogiri'

#
# rubygems
#
# require 'rubygems' # rubygems must be loaded from binary file (tree.rb) so $LOAD_PATH is not modified
require 'json'
require 'ansi/code'
begin
  require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/
rescue LoadError
  puts "to use color on Windows you can install win32console 'gem install win32console'"
end

#
# treevisitor
#

require 'tree_rb/version'
require 'tree_rb/extension_digest'
require 'tree_rb/extension_numeric'
require 'tree_rb/exception'

require 'tree_rb/core/abs_node'
require 'tree_rb/core/leaf_node'
require 'tree_rb/core/tree_node'
require 'tree_rb/core/basic_tree_node_visitor'
require 'tree_rb/core/tree_node_visitor'

require 'tree_rb/input_plugins/file_system/directory_walker'
require 'tree_rb/input_plugins/file_system/dir_processor'

require 'tree_rb/input_plugins/html_page/dom_walker'

#
# visitors
#

visitors_dir = File.join(File.dirname(__FILE__), 'tree_rb', 'visitors')
unless Dir.exist? visitors_dir
  raise "cannot found directory '#{visitors_dir}'"
end
Dir[ File.join(visitors_dir, '*.rb') ].each { |f|require f }

visitors_dir = File.join(File.dirname(__FILE__), 'tree_rb', 'visitors_file_system')
unless Dir.exist? visitors_dir
  raise "cannot found directory '#{visitors_dir}'"
end
Dir[ File.join(visitors_dir, '*.rb') ].each { |f|require f }

