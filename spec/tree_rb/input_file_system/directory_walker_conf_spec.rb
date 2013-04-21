# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe DirTreeWalker do

  it 'should accept option :ignore with regex' do
    walker = DirTreeWalker.new :ignore => /^\./
    walker.ignore_file?('.thumbnails').should be_true
    walker.ignore_dir?('.thumbnails').should be_true
  end

  it 'should accept option :ignore with string' do
    walker = DirTreeWalker.new :ignore => '.git'
    walker.ignore_file?('.git').should be_true
    walker.ignore_dir?('.git').should be_true
  end

  it 'should accept option :ignore_dir' do
    dtw = DirTreeWalker.new :ignore_dir => [/^\./, "private_dir" ]
    dtw.should be_ignore_dir ".git"
    dtw.should be_ignore_dir "private_dir"
  end

  it 'should accept option :ignore_file' do
    dtw = DirTreeWalker.new :ignore_file => [/.xml/, /(ignore)|(orig)/ ]
    dtw.should be_ignore_file "pippo.xml"
  end

  it 'should accept option :match with string' do
    dtw = DirTreeWalker.new :match => '.jpg'
    dtw.should be_match 'foo.jpg'
  end

  it 'should accept option :match with regex' do
    dtw = DirTreeWalker.new :match => /.jpg/
    dtw.should be_match 'foo.jpg'
  end

  it 'should ignore files and directory' do
    walker = DirTreeWalker.new(".")

    walker.ignore(/^\./)
    walker.ignore_file?('.thumbnails').should be_true
    walker.ignore_dir?('.thumbnails').should be_true

    walker.ignore_dir('thumbnails')
    walker.ignore_dir?('.thumbnails').should be_true
    walker.ignore_dir?('thumbnails').should be_true
    walker.ignore_dir?('pippo').should be_false

    walker.ignore_file('xvpics')
    walker.ignore_file?('xvpics').should be_true

    walker.ignore('sub')
    walker.ignore_file?('[Dsube]').should be_false
    walker.ignore_dir?('[Dsube]').should be_false
  end

end
