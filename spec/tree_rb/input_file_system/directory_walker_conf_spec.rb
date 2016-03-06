# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe DirTreeWalker do

  it 'should accept option :ignore with regex' do
    walker = DirTreeWalker.new :ignore => /^\./
    expect(walker.ignore_file?('.thumbnails')).to be true
    expect(walker.ignore_dir?('.thumbnails')).to be true
  end

  it 'should accept option :ignore with string' do
    walker = DirTreeWalker.new :ignore => '.git'
    expect(walker.ignore_file?('.git')).to be true
    expect(walker.ignore_dir?('.git')).to be true
  end

  it 'should accept option :ignore_dir' do
    dtw = DirTreeWalker.new :ignore_dir => [/^\./, "private_dir" ]
    expect(dtw.ignore_dir?('.git')).to be true
    expect(dtw.ignore_dir?('private_dir')).to be true
  end

  it 'should accept option :ignore_file' do
    dtw = DirTreeWalker.new :ignore_file => [/.xml/, /(ignore)|(orig)/ ]
    expect(dtw).to be_ignore_file('pippo.xml')
  end

  it 'should accept option :match with string' do
    dtw = DirTreeWalker.new :match => '.jpg'
    expect(dtw).to be_match('foo.jpg')
  end

  it 'should accept option :match with regex' do
    dtw = DirTreeWalker.new :match => /.jpg/
    expect(dtw).to be_match('foo.jpg')
  end

  it 'should ignore files and directory' do
    walker = DirTreeWalker.new('.')

    walker.ignore(/^\./)
    expect(walker.ignore_file?('.thumbnails')).to be true
    expect(walker.ignore_dir?('.thumbnails')).to be true

    walker.ignore_dir('thumbnails')
    expect(walker.ignore_dir?('.thumbnails')).to be true
    expect(walker.ignore_dir?('thumbnails')).to be true
    expect(walker.ignore_dir?('pippo')).to be false

    walker.ignore_file('xvpics')
    expect(walker.ignore_file?('xvpics')).to be true

    walker.ignore('sub')
    expect(walker.ignore_file?('[Dsube]')).to be false
    expect(walker.ignore_dir?('[Dsube]')).to be false
  end

end
