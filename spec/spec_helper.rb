$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'treevisitor'
include TreeVisitor

TEST_DATA = File.expand_path( File.join( File.dirname(__FILE__), "fixtures", "test_data" ) )


# Spec::Runner.configure do |config|
# end


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
