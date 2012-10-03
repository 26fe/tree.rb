# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe DomWalker do

  it "should capture all files" do
    value      = Nokogiri::HTML.parse(File.read(File.join(FIXTURES, "test_json", "1.json")))
    # pp value
    parent     = value.search("//body").first
    # recursive_search(parent)

    dom_walker = DomWalker.new(parent)
    dom_walker.run(FlatPrintTreeNodeVisitor.new)
    dom_walker.run(PrintTreeNodeVisitor.new)
  end

end

