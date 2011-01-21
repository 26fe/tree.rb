# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe TreeNodeVisitor do

  it "should initialize correctly" do
    visitor = TreeNodeVisitor.new do

      on_enter_tree_node do |tree_node|
        @entered_node = true
      end

      on_exit_tree_node do |tree_node|
        @exit_node = true
      end

      on_visit_leaf_node do |leaf_node|
        @visit_leaf = true
      end
    end

    visitor.enter_tree_node(nil)
    visitor.instance_eval{ @entered_node }.should be_true

    visitor.exit_tree_node(nil)
    visitor.instance_eval{ @exit_node }.should be_true

    visitor.visit_leaf_node(nil)
    visitor.instance_eval{ @visit_leaf }.should be_true
  end

end
