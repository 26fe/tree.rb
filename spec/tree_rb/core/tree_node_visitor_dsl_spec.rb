# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe TreeNodeVisitor do

  it "should initialize correctly" do
    visitor = TreeNodeVisitor.new do

      on_enter_node do |tree_node|
        @entered_node = true
      end

      on_exit_node do |tree_node|
        @exit_node = true
      end

      on_leaf do |leaf_node|
        @visit_leaf = true
      end
    end

    visitor.enter_node(nil)
    expect(visitor.instance_eval{ @entered_node }).to be true

    visitor.exit_node(nil)
    expect(visitor.instance_eval{ @exit_node }).to be true

    visitor.visit_leaf(nil)
    expect(visitor.instance_eval{ @visit_leaf }).to be true
  end

  it 'should initialize correctly' do
    visitor = TreeNodeVisitor.new do

      on_enter_node do |node, parent|
        @node = node
        @parent = parent
      end

      on_exit_node do |node, parent|
        @node = node
        @parent = parent
      end

      on_leaf do |leaf, parent|
        @leaf = leaf
        @parent = parent
      end
    end

    visitor.instance_eval{ @stack = ["p"] }
    visitor.enter_node("n")
    expect(visitor.instance_eval{ @node }).to be == "n"
    expect(visitor.instance_eval{ @parent }).to be == "p"
    expect(visitor.instance_eval{ @stack }).to have(2).node

    visitor.exit_node("n")
    expect(visitor.instance_eval{ @node }).to be == "n"
    expect(visitor.instance_eval{ @stack }).to have(1).node

    visitor.instance_eval{ @stack = ['p'] }
    visitor.visit_leaf('l')
    expect(visitor.instance_eval{ @leaf }).to be == 'l'
    expect(visitor.instance_eval{ @parent }).to be == 'p'
  end
end
