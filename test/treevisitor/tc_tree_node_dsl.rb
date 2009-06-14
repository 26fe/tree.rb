require File.join(File.dirname(__FILE__), "test_helper")

require 'treevisitor/tree_node.rb'


class DTreeNode < TreeNode
  def to_s
    "dt: #{name}"
  end
end

class DLeafNode < LeafNode
  def to_s
    "dl: #{name}"
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


class TCTreeNodeDsl < Test::Unit::TestCase

  def test_dsl

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
    assert_equal out, tree.to_str
  end

  def test_derivated
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
    assert_equal out, tree.to_str

    tree = DTreeNode.create(DLeafNode) do
      node "root" do
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3"
        end
      end
    end
    assert_equal out, tree.to_str
  end

  def test_derivated_args
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
    assert_equal out, tree.to_str
  end
end
