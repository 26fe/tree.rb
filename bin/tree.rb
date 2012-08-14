#!/usr/bin/env ruby
require 'rubygems'

cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)
require 'treevisitor_cli'

include TreeRb
exit CliTree.run
