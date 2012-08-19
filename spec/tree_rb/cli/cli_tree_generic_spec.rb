# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe CliTree do

  it "should accept --help switch" do
    captured = capture_output do
      args = %w{--help}
      CliTree.new.parse_args(args)
    end
    captured.out.should match /Usage:/
  end

  it "should accept --version switch" do
    captured     = capture_output do
      args = %w{--version}
      CliTree.new.parse_args(args)
    end
    version = TreeRb::VERSION
    captured.out.should match version
  end

  it "should accepts -d switch (directories only)" do
    captured = capture_output do
      args = %w{-d}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    captured.out.split("\n").length.should == 6
  end

  it "should accepts -da switch (directories only)" do
    captured = capture_output do
      args = %w{-da}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    captured.out.split("\n").length.should == 7
  end

  it "should accepts -a switch (all files)" do
    captured = capture_output do
      args = %w{-a}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # pp captured
    captured.out.split("\n").length.should == 11
  end

  it "should accepts -a switch (all files)" do
    captured = capture_output do
      args = []
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    captured.out.split("\n").length.should == 9
  end

  it "should show tree with inaccessible directories" do
    captured = capture_output do
      args = []
      args << File.join(FIXTURES, "test_dir_3_with_error")
      CliTree.new.parse_args(args)
    end
    #puts captured
    captured.err.should_not be_empty
    captured.out.split("\n").length.should == 4
  end
end
