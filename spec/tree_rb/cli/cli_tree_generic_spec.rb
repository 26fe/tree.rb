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
    expected = "test_dir_1\n|-- dir.1\n|   `-- dir.1.2\n`-- dir.2\n\n4 directories, 0 files\n"
    captured.out.should == expected
    captured.out.split("\n").length.should == 6
  end

  it "should accepts -da switch (directories only)" do
    captured = capture_output do
      args = %w{-da}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    expected = "test_dir_1\n|-- .dir_with_dot\n|-- dir.1\n|   `-- dir.1.2\n`-- dir.2\n\n5 directories, 0 files\n"
    captured.out.should == expected
    captured.out.split("\n").length.should == 7
  end

  it "should accepts -a switch (all files)" do
    captured = capture_output do
      args = %w{-a}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # pp captured
    expected ="test_dir_1\n|-- .dir_with_dot\n|   `-- dummy.txt\n|-- dir.1\n|   |-- file.1.1\n|   `-- dir.1.2\n|       `-- file.1.2.1\n`-- dir.2\n    `-- file.2.1\n\n5 directories, 4 files\n"
    captured.out.should == expected
    captured.out.split("\n").length.should == 11
  end

  it "should accepts -a switch (all files)" do
    captured = capture_output do
      args = []
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    expected ="test_dir_1\n|-- dir.1\n|   |-- file.1.1\n|   `-- dir.1.2\n|       `-- file.1.2.1\n`-- dir.2\n    `-- file.2.1\n\n4 directories, 3 files\n"
    captured.out.should == expected
    captured.out.split("\n").length.should == 9
  end

  it "should accepts -A switch (ascii line graphics)" do
    captured = capture_output do
      args = %w{-A}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    expected ="test_dir_1\n├── dir.1\n│   ├── file.1.1\n│   └── dir.1.2\n│       └── file.1.2.1\n└── dir.2\n    └── file.2.1\n\n4 directories, 3 files\n"
    captured.out.should == expected
  end

  it "should show tree with inaccessible directories" do
    captured = capture_output do
      args = []
      args << File.join(FIXTURES, "test_dir_3_with_error")
      CliTree.new.parse_args(args)
    end
    # puts captured

    expected_out="test_dir_3_with_error\n`-- accessible_dir\n\n2 directories, 0 files\n"
    expected_err=/Permission denied/
    captured.out.should == expected_out
    captured.err.should match expected_err
    captured.err.should_not be_empty
    captured.out.split("\n").length.should == 4
  end
end
