# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe CliTree do

  it 'should accepts --format html_partition' do
    captured = capture_output do
      args = %w{--format html_partition}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    captured.out.should match  /d3.layout.partition/
  end

  it 'should accepts --format html_tree' do
    captured = capture_output do
      args = %w{--format html_tree}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    captured.out.should match  /d3.layout.tree/
  end

  it 'should accepts --format html_treemap' do
    captured = capture_output do
      args = %w{--format html_treemap}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end
    captured.out.should match  /d3.layout.treemap/
  end
end
