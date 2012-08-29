#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#require 'rubygems'
cwd = File.expand_path( File.join( File.dirname(__FILE__), "..", "lib" ) )
$:.unshift(cwd) unless $:.include?(cwd)

require 'json'



# my_json = { :array => [1, 2, 3, { :sample => "hash"} ], :foo => "bar" }

if ARGV.length < 1
  puts "missing arg"
  exit
end

filename = ARGV[0]

unless File.exists?(filename) 
  puts "file not exists '#{filename}'"
  exit
end

my_json_str = File.read(filename)
puts "*************************"
puts my_json_str
puts "*************************"

my_json = JSON(my_json_str)


puts JSON.pretty_generate(my_json)
