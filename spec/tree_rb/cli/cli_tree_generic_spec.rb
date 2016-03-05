# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe CliTree do

  it "should accept --help switch" do
    captured = capture_output do
      args = %w{--help}
      CliTree.new.parse_args(args)
    end
    expect(captured.out).to match(/Usage:/)
  end

  it "should accept --version switch" do
    captured     = capture_output do
      args = %w{--version}
      CliTree.new.parse_args(args)
    end
    version = TreeRb::VERSION
    expect(captured.out).to match(version)
  end

  it "should accepts -d switch (directories only)" do
    captured = capture_output do
      args = %w{-d}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    expected = "test_dir_1\n|-- dir.1\n|   `-- dir.1.2\n`-- dir.2\n\n4 directories, 0 files\n"
    expect(captured.out).to be == expected
    expect(captured.out.split("\n").length).to be == 6
  end

  it "should accepts -da switch (directories only)" do
    captured = capture_output do
      args = %w{-da}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    expected = "test_dir_1\n|-- .dir_with_dot\n|-- dir.1\n|   `-- dir.1.2\n`-- dir.2\n\n5 directories, 0 files\n"
    expect(captured.out).to be == expected
    expect(captured.out.split("\n").length).to be == 7
  end

  it "should accepts -a switch (all files)" do
    captured = capture_output do
      args = %w{-a}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # pp captured
    expected ="test_dir_1\n|-- .dir_with_dot\n|   `-- dummy.txt\n|-- dir.1\n|   |-- file.1.1\n|   `-- dir.1.2\n|       `-- file.1.2.1\n`-- dir.2\n    `-- file.2.1\n\n5 directories, 4 files\n"
    expect(captured.out).to be == expected
    expect(captured.out.split("\n").length).to be == 11
  end

  it "should accepts -a switch (all files)" do
    captured = capture_output do
      args = []
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    expected ="test_dir_1\n|-- dir.1\n|   |-- file.1.1\n|   `-- dir.1.2\n|       `-- file.1.2.1\n`-- dir.2\n    `-- file.2.1\n\n4 directories, 3 files\n"
    expect(captured.out).to be == expected
    expect(captured.out.split("\n").length).to be == 9
  end

  it "should accepts -A switch (ascii line graphics)" do
    captured = capture_output do
      args = %w{-A}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    # puts captured
    expected = <<EOS
test_dir_1
├── dir.1
│   ├── file.1.1
│   └── dir.1.2
│       └── file.1.2.1
└── dir.2
    └── file.2.1

4 directories, 3 files
EOS
    expect(captured.out.encode('utf-8')).to be == expected.encode('utf-8') 
  end

  it "should show tree with inaccessible directories" do

#    begin
      d = File.join(FIXTURES, "test_dir_3_with_error", "no_accessible_dir")
      if File.exists?(d)
        File.chmod(0644,d) 
        Dir.rmdir(d) 
      end
      FileUtils.mkdir(d)
      File.chmod(0000, d)
#    rescue
#    end

    captured = capture_output do
      args = []
      args << File.join(FIXTURES, "test_dir_3_with_error")
      CliTree.new.parse_args(args)
    end
    # puts captured

    expected_out= <<EOS
test_dir_3_with_error
`-- accessible_dir

2 directories, 0 files
EOS
    expected_err=/Permission denied/

    expect(captured.out).to be == expected_out
    expect(captured.err).to match(expected_err)
    expect(captured.err).not_to be_empty
    expect(captured.out.split("\n").length).to be == 4

    # File.chmod(0644,d) 
    # Dir.unlink(d) 
  end
end
