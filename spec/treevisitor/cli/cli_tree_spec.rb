require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

# require 'treevisitor/cli/cli_tree'

describe CliTree do

  it "test_help_message" do
    out = with_stdout_captured do
      args = %w{-h}
      CliTree.new.parse_args(args)
    end
    out.should match /Usage:/
  end

  it "test_version" do
    out = with_stdout_captured do
      args = %w{--version}
      CliTree.new.parse_args(args)
    end
    version = "0.1.0"
    out.should match version
  end

  it "test_directories_only" do
    out = with_stdout_captured do
      args = %w{-d}
      args << TEST_DATA
      CliTree.new.parse_args(args)
    end
    # puts out
    out.split("\n").length.should == 6

    out = with_stdout_captured do
      args = %w{-da}
      args << TEST_DATA
      CliTree.new.parse_args(args)
    end
    #puts out
    out.split("\n").length.should == 7
  end

  it "test_all_files" do
    out = with_stdout_captured do
      args = %w{-a}
      args << TEST_DATA
      CliTree.new.parse_args(args)
    end
    # puts out
    out.split("\n").length.should == 11

    out = with_stdout_captured do
      args = []
      args << TEST_DATA
      CliTree.new.parse_args(args)
    end
    # puts out
    out.split("\n").length.should == 9
  end
end