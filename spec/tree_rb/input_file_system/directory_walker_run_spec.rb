# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe DirTreeWalker do

  it 'should raise exception when run on inexistent directory' do

    dtw = DirTreeWalker.new(match: /.jpg/)
    root_dir = 'C:\GioProg\interzone\Dropbox\foto.altro\wallpapers\1920x1200_dell_16x10\color'
    dtw.run root_dir do
      on_leaf do |pathname|
        puts "- #{pathname}"
      end
    end

  end

  it 'should accumulate file names' do
    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir_1"))

    accumulator     = []
    visitor         = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    accumulator.length.should == 9
    accumulator.sort.should == %w{ test_dir_1 dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 .dir_with_dot dummy.txt }.sort
  end

  it 'should accumulate file names 2' do
    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir_2"))
    dir_tree_walker.ignore('sub')

    accumulator = []
    visitor     = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    accumulator.length.should == 2
    accumulator.sort.should == %w{ [Dsube] test_dir_2 }.sort
  end

  it 'should ignore not accessible directory' do

    dir = File.join(FIXTURES, 'test_dir_3_with_error')

    f1 = File.join(dir, 'no_accessible_dir')
    Dir.rmdir(f1) if File.exist?(f1)
    Dir.mkdir(f1, 0000)

    f2 = File.join(dir, "accessible_dir")
    Dir.rmdir(f2) if File.exist?(f2)
    Dir.mkdir(f2)

    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir_3_with_error"))
    accumulator = []
    visitor     = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    accumulator.length.should == 2
    accumulator.sort.should == %w{accessible_dir test_dir_3_with_error }.sort

    # Dir.rmdir(f1)
    # Dir.rmdir(f2)
  end

end
