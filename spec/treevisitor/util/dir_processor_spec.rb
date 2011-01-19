# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe DirProcessor do

  it do
    files = []
    dp    = DirProcessor.new { |f| files << f }
    dp.process(FIXTURES)
    files.length.should == 3
  end

end
