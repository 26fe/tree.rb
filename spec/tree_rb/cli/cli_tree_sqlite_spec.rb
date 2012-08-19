# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe CliTree do

  it "should accepts '--format sqlite -o test.db' switches" do
    db_filename = File.join(FIXTURES, 'tmp', 'test.db')

    File.unlink(db_filename) if File.exist?(db_filename)

    captured = capture_output do
      args = %w{--format sqlite -o } << db_filename
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end

    File.exist?(db_filename).should be_true

    File.unlink(db_filename) if File.exist?(db_filename)
  end

end
