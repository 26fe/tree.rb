# -*- coding: utf-8 -*-

require File.expand_path( File.join(File.dirname(__FILE__), "..", "spec_helper") )

describe "TCNumeric" do

  it "test_simple" do
    10.with_separator.should == "10"
    10.0.with_separator.should == "10.0"
    1000000.with_separator.should == "1,000,000"
  end

end