# -*- coding: utf-8 -*-
#
# std lib
#
require 'stringio'
require 'ostruct'

require 'rspec/collection_matchers'

#
# gem
#
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'tree_rb'
require 'tree_rb_cli'
include TreeRb

FIXTURES = File.expand_path( File.join( File.dirname(__FILE__), 'fixtures') )

def capture_output
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
  OpenStruct.new(:out => out.string, :err => err.string)
end
