# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe "TreeNodeDsl" do

  it "should build tree with dsl" do
    tree = TreeNode.create do
      node "root" do
        leaf "l1"
        leaf "l2"
        node "sub" do
          leaf "l3"
        end
        node "wo leaves"
      end
    end

    # puts tree.to_str
    out =<<EOS
root
|-- l1
|-- l2
|-- sub
|   `-- l3
`-- wo leaves
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

end
