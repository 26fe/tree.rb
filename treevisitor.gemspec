# -*- encoding: utf-8; mode: ruby -*-
$:.push File.expand_path("../lib", __FILE__)
require "treevisitor/version"

Gem::Specification.new do |gem|
  gem.name = "treevisitor"
  gem.version = TreeVisitor::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.summary = "Implementation of visitor design pattern"
  gem.description = <<-EOF
      Gem renamed to tree.rb
      Implementation of visitor design pattern. It contains a 'tree.rb'
      command line clone of the tree unix tool.
  EOF

  gem.authors = ["Tokiro"]
  gem.email = "tokiro.oyama@gmail.com"
  gem.homepage = "http://github.com/tokiro/treevisitor"

  #
  # dependencies
  #

  gem.add_runtime_dependency(%q<tree.rb>, [">= 0"])

  #
  # files
  #
  gem.files = %w{LICENSE.txt README.md Rakefile treevisitor.gemspec}
  gem.files.concat Dir['tasks/**/*.rake']

  s.post_install_message =<<-EOS
  #######################################################

  WARNING This gem (treevisitor) was renamed to tree.rb, please update your dependencies.

  #######################################################

EOS
  gem.files = %w{LICENSE.txt README.md Rakefile treevisitor.gemspec}

end
