# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe CliTree do


  before(:each) do
    @db_filename = File.join(FIXTURES, 'tmp', 'test.db')
  end

  after(:each) do
    File.unlink(@db_filename) if File.exist?(@db_filename)
  end

  it "should accepts '--format sqlite -o test.db' switches" do

    captured = capture_output do
      args = %w{--format sqlite -o } << @db_filename
      args << File.join(FIXTURES, 'test_dir_1')
      CliTree.new.parse_args(args)
    end
    File.exist?(@db_filename).should be_true

    db = SQLite3::Database.new(@db_filename)
    ar = db.execute('select count(*) from files')
    nr_files = ar[0][0]
    nr_files.should == 3
  end

end
