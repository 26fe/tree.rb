# -*- coding: utf-8 -*-
#
# std lib
#
require "stringio"

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'treevisitor'
require 'treevisitor_cli'
include TreeRb

FIXTURES = File.expand_path( File.join( File.dirname(__FILE__), "fixtures" ) )

def with_output_captured
  old_stdout, old_stderr = $stdout, $stderr
  out = StringIO.new
  err = StringIO.new
  $stdout = out
  $stderr = err
  begin
    yield
  ensure
    $stdout = old_stdout
    $stderr = old_stderr
  end
  { :stdout => out.string, :stderr => err.string }
end
