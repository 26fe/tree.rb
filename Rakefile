#!/usr/bin/env rake
# -*- encoding: utf-8; mode: ruby -*-
require 'bundler/gem_tasks'
#Bundler::GemHelper.install_tasks
#require 'rubygems'
#require 'rake'

# Load tasks
Dir.glob('tasks/**/*.rake').each { |r| Rake.application.add_import r }

task :test => :spec
task :default => :spec
