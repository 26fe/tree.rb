# -*- encoding: utf-8; mode: ruby -*-
$:.push File.expand_path("../lib", __FILE__)
require "treevisitor/version"

Gem::Specification.new do |gem|
  gem.name = "treevisitor"
  gem.version = TreeVisitor::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.summary = "Implementation of visitor design pattern"
  gem.description = <<-EOF
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
  gem.add_runtime_dependency(%q<json>, [">= 0"])

  gem.add_development_dependency(%q<rake>, [">= 0"])
  gem.add_development_dependency(%q<yard>, [">= 0"])
  gem.add_development_dependency(%q<bundler>, [">= 0"])
  gem.add_development_dependency(%q<rspec>, [">= 0"])

  #
  # files
  #
  # s.files         = `git ls-files`.split("\n")
  gem.files = %w{LICENSE.txt README.md Rakefile treevisitor.gemspec .gemtest}
  gem.files.concat Dir['lib/**/*.rb']
  gem.files.concat Dir['tasks/**/*.rake']
  gem.files.concat Dir['examples/**/*']

  #
  # test files
  #
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.test_files = Dir['spec/**/*.rb']
  gem.test_files.concat Dir['spec/fixtures/**/*']
  gem.test_files.concat Dir['spec/fixtures/**/.gitkeep']
  gem.test_files.concat Dir['spec/fixtures/**/.dir_with_dot/*']

  gem.require_paths = ["lib"]
 
  gem.post_install_message = "This gems was renamed to tree.rb, please update your dependencies"
end
