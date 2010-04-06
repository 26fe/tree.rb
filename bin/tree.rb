#!/usr/bin/env ruby
#
# Wrapper for the class CliTree

require 'rubygems'
begin
  require 'treevisitor'
rescue LoadError
  cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "lib" ) )
  $:.unshift(cwd) unless $:.include?(cwd)
  require 'treevisitor'
end

include TreeVisitor
exit CliTree.run
