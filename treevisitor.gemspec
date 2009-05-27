# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{treevisitor}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tokiro"]
  s.date = %q{2009-05-27}
  s.default_executable = %q{dirtree.rb}
  s.email = %q{tokiro.oyama@gmail.com}
  s.executables = ["dirtree.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "lib/gf_utility/file_utilities.rb",
     "lib/gf_utility/kwartzhelper.rb",
     "lib/gf_utility/md5.rb",
     "lib/gf_utility/numeric.rb",
     "lib/treevisitor.rb",
     "lib/treevisitor/abs_node.rb",
     "lib/treevisitor/build_dir_tree_visitor.rb",
     "lib/treevisitor/cli/cli_dir_tree.rb",
     "lib/treevisitor/dir_processor.rb",
     "lib/treevisitor/dir_tree_walker.rb",
     "lib/treevisitor/leaf_node.rb",
     "lib/treevisitor/tree_node.rb",
     "lib/treevisitor/tree_node_visitor.rb",
     "lib/treevisitor/visitor/print_node_visitor2.rb",
     "test_data/gf_utility/kwartz_test_data/source/test1.html",
     "test_data/tree_visitor/test_data/dir.1/dir.1.2/file.1.2.1",
     "test_data/tree_visitor/test_data/dir.1/file.1.1",
     "test_data/tree_visitor/test_data/dir.2/file.2.1"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tokiro/treevisitor}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{treevisitor}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{implementation of visitor design pattern}
  s.test_files = [
    "test/treevisitor/tc_dir_processor.rb",
     "test/treevisitor/tc_dir_tree_walker.rb",
     "test/treevisitor/tc_tree_node.rb",
     "test/treevisitor/tc_tree_node_visitor.rb",
     "test/treevisitor/test_helper.rb",
     "test/gf_utility/tc_md5.rb",
     "test/gf_utility/tc_kwartz.rb",
     "test/gf_utility/tc_numeric.rb",
     "test/gf_utility/test_helper.rb",
     "test/ts_treevisitor.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<abstract>, [">= 0"])
    else
      s.add_dependency(%q<abstract>, [">= 0"])
    end
  else
    s.add_dependency(%q<abstract>, [">= 0"])
  end
end
