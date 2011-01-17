# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe TreeNodeVisitor do

  it "should initialize correctly" do
    TreeNodeVisitor.new do
      puts "prova"
    end
  end

end
