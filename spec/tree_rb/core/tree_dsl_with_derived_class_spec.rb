# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe "Tree Node Dsl Derived Class with no-arg constructor " do

  class DTreeNode < TreeNode
    def content
      "dt: #{super}"
    end
  end

  class DLeafNode < LeafNode
    def content
      "dl: #{super}"
    end
  end

  it "dsl with non-arg constructor" do
    tree = TreeNode.create(DTreeNode, DLeafNode) do
      node "root" do
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3"
        end
      end
    end

    # puts tree.to_str
    out =<<EOS
dt: root
|-- dl: l1
|-- dl: l2
`-- dt: sub
    `-- dl: l3
EOS
    expect(tree.to_str).to be == out

    tree = DTreeNode.create(DLeafNode) do
      node "root" do
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3"
        end
      end
    end
    expect(tree.to_str).to be == out
  end

end
