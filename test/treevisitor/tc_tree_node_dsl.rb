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

class TCTreeNodeDsl < Test::Unit::TestCase

  def test_dsl

    tree = TreeNode.create do
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
root
|-- l1
|-- l2
`-- sub
    `-- l3
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

end
