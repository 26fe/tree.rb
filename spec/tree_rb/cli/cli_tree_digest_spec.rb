# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe CliTree do

  it "should accepts --md5sum switch" do
    captured = capture_output do
      args = %w{--md5sum}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end

    certified_out=<<-EOS
a4788ba25d42f21003db11ec53112f1e  file.1.1
afb96f2652f4ba3cd84f7be0ae6fffe3  file.1.2.1
c4c0c530b842efe4038ac4a659bfbe77  file.2.1
EOS
    expect(captured.out).to be == certified_out
  end

  it "should accepts --sha1sum switch" do
    captured = capture_output do
      args = %w{--sha1sum}
      args << File.join(FIXTURES, "test_dir_1")
      CliTree.new.parse_args(args)
    end

    certified_out=<<-EOS
9140d4031d95f459eb0bee8160509e5d83271fe8  file.1.1
4b7f45a8c0be069e7eac5f7d64b997c92c740656  file.1.2.1
3c58aeb1552b0318a86279b52c918f2fb953b4b9  file.2.1
EOS
    expect(captured.out).to be == certified_out
  end

end
