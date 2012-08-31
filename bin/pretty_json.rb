#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#require 'rubygems'
cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)

require 'json'

show_input = false
if ARGV.length < 1
  $stderr.puts "missing arg"
  exit
end

filename = ARGV[0]

unless File.exists?(filename) 
  $stderr.puts "file not exists '#{filename}'"
  exit
end

my_json_str = File.read(filename)

if show_input
  $stderr.puts "*************************"
  $stderr.puts my_json_str
  $stderr.puts "*************************"
end

begin
  my_json = JSON(my_json_str)
rescue JSON::ParserError
  $stderr.puts "json is malformed"
  exit 1
end

puts JSON.pretty_generate(my_json)

