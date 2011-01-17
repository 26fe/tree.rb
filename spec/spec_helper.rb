#
# std lib
#
require "stringio"

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'treevisitor'
require 'treevisitor_cli'
include TreeVisitor

FIXTURES = File.expand_path( File.join( File.dirname(__FILE__), "fixtures" ) )

def with_stdout_captured
  old_stdout = $stdout
  out = StringIO.new
  $stdout = out
  begin
    yield
  ensure
    $stdout = old_stdout
  end
  out.string
end
