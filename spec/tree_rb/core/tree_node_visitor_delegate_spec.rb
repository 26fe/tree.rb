# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe TreeNodeVisitor do

  class Delegate
    def enter_node(node)
      @entered_node= true
    end

    def exit_node(node)
      @exit_node= true
    end

    def visit_leaf(leaf)
      @visited_leaf= true
    end
  end

  it "should use a delegate" do

    delegate = Delegate.new
    visitor = TreeNodeVisitor.new(delegate)

    visitor.enter_node(nil)
    expect(delegate.instance_eval{ @entered_node }).to be true

    visitor.exit_node(nil)
    expect(delegate.instance_eval{ @exit_node }).to be true

    visitor.visit_leaf(nil)
    expect(delegate.instance_eval{ @visited_leaf }).to be true
  end

end
