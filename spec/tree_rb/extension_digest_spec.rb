# -*- coding: utf-8 -*-
require File.expand_path( File.join(File.dirname(__FILE__), '..', 'spec_helper') )

describe 'MD5' do

  before do
    @file_name = File.expand_path( File.join( File.dirname(__FILE__), "..", "..", "lib", "tree_rb", "extension_digest.rb" ) )
  end

  it 'should calculate md5' do
    expect(MD5.file( @file_name ).to_s).to be == 'b33c6b70109037fc02686f8babfc2db4'
  end

  it 'should calculate sha1' do
    expect(SHA1.file( @file_name ).to_s).to be == 'f99700dbdd200d7255f586ceb0cac05e05871cc5'
  end

end
