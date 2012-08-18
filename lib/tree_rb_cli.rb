# -*- coding: utf-8 -*-

#
# stdlib
#
require 'optparse'

#
# gem
#

begin
  require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/
rescue LoadError
  puts 'You must gem install win32console to use color on Windows'
end

#
# tree_rb cli
#
require 'tree_rb'
require "tree_rb/cli/cli_tree"
