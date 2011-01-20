# -*- coding: utf-8 -*-
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.name = "treevisitor"
    gem.summary = "Implementation of visitor design pattern"
    gem.description = <<-EOF
      Implementation of visitor design pattern. It contains a 'tree.rb'
      command line clone of the tree unix tool.
    EOF

    gem.authors = ["Tokiro"]
    gem.email = "tokiro.oyama@gmail.com"
    gem.homepage = "http://github.com/tokiro/treevisitor"

    #
    # dependencies automatically loaded from Gemfile
    #

    #
    # bin
    #
    gem.executables = %w{ tree.rb }

    #
    # files
    #
    gem.files  = %w{LICENSE.txt README.md Rakefile VERSION.yml treevisitor.gemspec}
    gem.files.concat Dir['lib/**/*.rb']
    gem.files.concat Dir['tasks/**/*.rake']
    gem.files.concat Dir['examples/**/*']


    #
    # test files
    #
    gem.test_files = Dir['spec/**/*.rb']
    gem.test_files.concat Dir['spec/fixtures/**/*']
    gem.test_files.concat Dir['spec/fixtures/**/.dir_with_dot/*']

    #
    # rubyforge
    #
    # gem.rubyforge_project = 'treevisitor'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
