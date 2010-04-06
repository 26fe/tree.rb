require File.join(File.dirname(__FILE__), "..", "test_helper")

require 'treevisitor/cli/cli_tree'

class TCCliTree < Test::Unit::TestCase

  TEST_DIRECTORY = File.join( TREEVISITOR_HOME, "test_data", "tree_visitor", "test_data" )

  def test_help_message
    out = with_stdout_captured do
      args = %w{-h}
      CliTree.new.parse_args(args)
    end
    assert_match /Usage:/, out
  end

  def test_version
    out = with_stdout_captured do
      args = %w{--version}
      CliTree.new.parse_args(args)
    end
    version = "0.0.20"
    assert_match version, out
  end

  def test_directories_only
    out = with_stdout_captured do
      args = %w{-d}
      args << TEST_DIRECTORY
      CliTree.new.parse_args(args)
    end
    # puts out
    assert_equal 6, out.split("\n").length

    out = with_stdout_captured do
      args = %w{-da}
      args << TEST_DIRECTORY
      CliTree.new.parse_args(args)
    end
    #puts out
    assert_equal 7, out.split("\n").length
  end

  def test_all_files
    out = with_stdout_captured do
      args = %w{-a}
      args << TEST_DIRECTORY
      CliTree.new.parse_args(args)
    end
    # puts out
    assert_equal 11, out.split("\n").length

    out = with_stdout_captured do
      args = []
      args << TEST_DIRECTORY
      CliTree.new.parse_args(args)
    end
    # puts out
    assert_equal 9, out.split("\n").length
  end
end
