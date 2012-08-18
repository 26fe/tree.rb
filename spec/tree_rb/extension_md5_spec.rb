# -*- coding: utf-8 -*-
require File.expand_path( File.join(File.dirname(__FILE__), "..", "spec_helper") )
describe "MD5" do
  it "test_simple_md5" do
    file_name = File.expand_path( File.join( File.dirname(__FILE__), "..", "..", "lib", "tree_rb", "extension_md5.rb" ) )
    MD5.file( file_name ).to_s.should  ==  "ccd18527b14ec24ac250cb76f730b2dd"
  end
end
