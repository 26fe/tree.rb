# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe "Tree Node Dsl Derived Class with n-arg constructor" do

  class ArgsTreeNode < TreeNode
    attr_reader :description

    def initialize(name, description, parent)
      content = "a: #{description}"
      super(content, parent)
      @description = description
    end

  end

  class ArgsLeafNode < LeafNode
    attr_reader :description

    def initialize(name, description, parent)
      content = "a: #{description}"
      super(content, parent)
      @description = description
    end

  end

  it "test_derivated_args" do
    tree = TreeNode.create(ArgsTreeNode, ArgsLeafNode) do
      node "root", "droot" do
        leaf "l1", "dl1"
        leaf "l2", "dl2"
        node "sub", "dsub" do
          leaf "l3", "dl3"
        end
      end
    end

    # puts tree.to_str
    out =<<EOS
a: droot
|-- a: dl1
|-- a: dl2
`-- a: dsub
    `-- a: dl3
EOS
    expect(tree.to_str).to be == out
  end
end
