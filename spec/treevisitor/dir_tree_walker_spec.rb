# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe DirTreeWalker do

  it "should ignore files and directory" do
    dtp = DirTreeWalker.new(".")

    dtp.ignore(/^\./)
    dtp.ignore_file?(".thumbnails").should be_true
    dtp.ignore_dir?(".thumbnails").should be_true

    dtp.ignore_dir("thumbnails")
    dtp.ignore_dir?(".thumbnails").should be_true
    dtp.ignore_dir?("thumbnails").should be_true
    dtp.ignore_dir?("pippo").should be_false

    dtp.ignore_file("xvpics")
    dtp.ignore_file?("xvpics").should be_true

    dtp.ignore("sub")
    dtp.ignore_file?("[Dsube]").should be_false
    dtp.ignore_dir?("[Dsube]").should be_false
  end

  it "should accumulate file names" do
    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir"))

    accumulator     = []
    visitor         = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    accumulator.length.should == 9
    accumulator.sort.should == %w{ test_dir dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 .dir_with_dot dummy.txt}.sort
  end

  it "should accumulate file names 2" do
    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir_2"))
    dir_tree_walker.ignore("sub")

    accumulator = []
    visitor     = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    # accumulator.length.should == 4
    accumulator.sort.should == %w{ [Dsube] test_dir_2}.sort
  end

end
