# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe "TreeNodeDsl" do

  class DTreeNode < TreeNode
    def to_s
      "dt: #{content}"
    end
  end

  class DLeafNode < LeafNode
    def to_s
      "dl: #{content}"
    end
  end

  class ArgsTreeNode < TreeNode

    attr_reader :description

    def initialize(name, description, parent)
      super(name, parent)
      @description =  description
    end

    def to_s
      "a: #{description}"
    end
  end

  class ArgsLeafNode < LeafNode

    attr_reader :description

    def initialize(name, description, parent)
      super(name, parent)
      @description =  description
    end

    def to_s
      "a: #{description}"
    end
  end



  it "test_dsl" do
    tree = TreeNode.create do
      node "root" do
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3"
        end
        node "woleaves"
      end
    end

    # puts tree.to_str
    out =<<EOS
root
|-- l1
|-- l2
|-- sub
|   `-- l3
`-- woleaves
EOS
    tree.to_str.should == out
  end

  it "test_dsl_block_with_arg" do
    tree = TreeNode.create do
      node "root" do |node|
        node.prefix_path=("pre/")        
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3" do |leaf|            
          end
        end
        node "woleaves"
      end
    end

    # puts tree.to_str
    out =<<EOS
root
|-- l1
|-- l2
|-- sub
|   `-- l3
`-- woleaves
EOS
    tree.to_str.should ==  out
    tree.find("l3").path_with_prefix.should == "pre/root/sub/l3"
  end

  it "test_derivated" do
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
    tree.to_str.should == out

    tree = DTreeNode.create(DLeafNode) do
      node "root" do
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3"
        end
      end
    end
    tree.to_str.should == out
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
    tree.to_str.should == out
  end
end
