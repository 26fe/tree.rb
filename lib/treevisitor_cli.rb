# -*- coding: utf-8 -*-
#
# cli
#

require 'optparse'
require 'treevisitor'

begin
  require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/
rescue LoadError
  puts 'You must gem install win32console to use color on Windows'
end

#
# gem
#
require "tree_rb/cli/cli_tree"
