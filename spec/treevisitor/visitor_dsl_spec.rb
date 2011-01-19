# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe TreeNodeVisitor do

  it "should initialize correctly" do
    visitor = TreeNodeVisitor.new do
      on_enter_tree_node do |tree_node|
        "on_enter_tree_node"
      end

      on_exit_tree_node do |tree_node|
        "on_exit_tree_node"
      end

      on_visit_leaf_node do |leaf_node|
        "on_visit_leaf_node"
      end
    end

    visitor.enter_tree_node(nil).should == "on_enter_tree_node"
    visitor.exit_tree_node(nil).should == "on_exit_tree_node"
    visitor.visit_leaf_node(nil).should == "on_visit_leaf_node"
  end

end
