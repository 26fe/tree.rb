TREEVISITOR_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", ".." ) )

lib_dir  = File.join(TREEVISITOR_HOME, "lib" )
test_dir = File.join(TREEVISITOR_HOME, "test" )
$:.unshift lib_dir  unless $:.include?(lib_dir)
$:.unshift test_dir unless $:.include?(test_dir)

require 'test/unit'

require "stringio"
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
