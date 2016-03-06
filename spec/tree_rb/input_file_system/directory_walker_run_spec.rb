# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe DirTreeWalker do

  it 'should raise exception when run on inexistent directory' do

    captured = capture_output do
      dtw = DirTreeWalker.new(match: /.jpg/)
      root_dir = '/not_existent/'
      dtw.run root_dir do
        on_leaf do |pathname|
          puts "- #{pathname}"
        end
      end
    end
    expected = /No such file or directory @ dir_initialize - \/not_existent\n/
    expect(captured.err).to match expected

  end

  it 'should accumulate file names' do

    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir_1"))

    accumulator     = []
    visitor         = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    expect(accumulator.length).to be == 9
    expect(accumulator.sort).to be == %w{ test_dir_1 dir.1 dir.1.2 file.1.2.1 file.1.1 dir.2 file.2.1 .dir_with_dot dummy.txt }.sort

  end

  it 'should accumulate file names 2' do

    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, "test_dir_2"))
    dir_tree_walker.ignore('sub')

    accumulator = []
    visitor     = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }
    dir_tree_walker.run(visitor)
    expect(accumulator.length).to be == 2
    expect(accumulator.sort).to be == %w{ [Dsube] test_dir_2 }.sort

  end

  it 'should ignore not accessible directory' do

    dir = File.join(FIXTURES, 'test_dir_3_with_error')

    f1 = File.join(dir, 'no_accessible_dir')
    Dir.rmdir(f1) if File.exist?(f1)
    Dir.mkdir(f1, 0000)

    f2 = File.join(dir, 'accessible_dir')
    Dir.rmdir(f2) if File.exist?(f2)
    Dir.mkdir(f2)

    dir_tree_walker = DirTreeWalker.new(File.join(FIXTURES, 'test_dir_3_with_error'))
    accumulator = []
    visitor     = BlockTreeNodeVisitor.new { |pathname| accumulator << File.basename(pathname) }

    captured = capture_output do
      dir_tree_walker.run(visitor)
    end
    expect(accumulator.length).to be == 2
    expect(accumulator.sort).to be == %w{accessible_dir test_dir_3_with_error }.sort

    # Dir.rmdir(f1)
    # Dir.rmdir(f2)
  end

end
