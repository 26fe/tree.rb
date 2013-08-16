# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe CliJson do

  it 'should accepts --help switch' do
    captured = capture_output do
      args = %w{--help}
      # args << File.join(FIXTURES, "test_dir_1")
      CliJson.new.parse_args(args)
    end
    captured.out.should match /Usage:/
  end

  it 'should accept --version switch' do
    captured     = capture_output do
      args = %w{--version}
      CliJson.new.parse_args(args)
    end
    version = TreeRb::VERSION
    captured.out.should match version
  end

  it 'should format simple json file' do
    captured = capture_output do
      args = []
      args << File.join(FIXTURES, 'test_json', '1.json')
      CliJson.new.parse_args(args)
    end

    certified_out=<<-EOS
{
  "a": 1,
  "b": 2
}
EOS
    captured.out.should == certified_out
  end

end
