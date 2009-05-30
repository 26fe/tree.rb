require File.join(File.dirname(__FILE__), "..", "test_helper")

require 'treevisitor/cli/cli_tree'

class TCCliTree < Test::Unit::TestCase

  TEST_DIRECTORY = File.join( $TREEVISITOR_HOME, "test_data", "tree_visitor", "test_data" )

  def test_help_message
    out = with_stdout_captured do
      args = %w{-h}
      CliTree.new.parse_args(args)
    end
    assert out.start_with?("Usage:")
  end

  def test_all_files
    out = with_stdout_captured do
      args = %w{-a}
      args << TEST_DIRECTORY
      CliTree.new.parse_args(args)
    end
    # puts out
    assert_equal 10, out.split("\n").length

    out = with_stdout_captured do
      args = []
      args << TEST_DIRECTORY
      CliTree.new.parse_args(args)
    end
    # puts out
    assert_equal 8, out.split("\n").length
  end
end
