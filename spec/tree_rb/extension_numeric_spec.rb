# -*- coding: utf-8 -*-

require File.expand_path( File.join(File.dirname(__FILE__), "..", "spec_helper") )

describe "TCNumeric" do

  it "test_simple" do
    expect(10.with_separator).to be == "10"
    expect(10.0.with_separator).to be == "10.0"
    expect(1000000.with_separator).to be == "1,000,000"
  end

end