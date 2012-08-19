# -*- encoding: utf-8; mode: ruby -*-

Gem::Specification.new do |gem|
  gem.name = "treevisitor"
  gem.version = "0.2.4"

  gem.platform = Gem::Platform::RUBY
  gem.summary = "Implementation of visitor design pattern"
  gem.description = <<-EOF
      Gem renamed to tree.rb (https://rubygems.org/gems/tree.rb). Please update your dependencies.

      Implementation of visitor design pattern. It contains a 'tree.rb'
      command line clone of the tree unix tool.
  EOF

  gem.authors = ["Tokiro"]
  gem.email = "tokiro.oyama@gmail.com"
  gem.homepage = "http://github.com/tokiro/treevisitor"
  gem.require_paths = %w{ lib }

  #
  # dependencies
  #

  gem.add_runtime_dependency(%q<tree.rb>, [">= 0"])

  #
  # files
  #
  gem.files = %w{LICENSE.txt README.md Rakefile treevisitor.gemspec}
  gem.files.concat Dir['lib/**/*.rb']

  gem.post_install_message =<<-EOS
  #######################################################

  WARNING This gem (treevisitor) was renamed to tree.rb, please update your dependencies.

  #######################################################

EOS

end
