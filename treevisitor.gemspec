# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{treevisitor}
  s.version = "0.0.15"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["gf"]
  s.date = %q{2009-06-09}
  s.default_executable = %q{tree.rb}
  s.description = %q{      Implementation of visitor design pattern. It contains a 'tree.rb'
      command line clone of the tree unix tool.
}
  s.email = %q{giovanni.ferro@gmail.com}
  s.executables = ["tree.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "VERSION",
     "lib/gf_utilities/file_utilities.rb",
     "lib/gf_utilities/kwartzhelper.rb",
     "lib/gf_utilities/md5.rb",
     "lib/gf_utilities/numeric.rb",
     "lib/treevisitor.rb",
     "lib/treevisitor/abs_node.rb",
     "lib/treevisitor/cli/cli_tree.rb",
     "lib/treevisitor/dir_processor.rb",
     "lib/treevisitor/dir_tree_walker.rb",
     "lib/treevisitor/leaf_node.rb",
     "lib/treevisitor/tree_node.rb",
     "lib/treevisitor/tree_node_visitor.rb",
     "lib/treevisitor/visitors/block_tree_node_visitor.rb",
     "lib/treevisitor/visitors/build_dir_tree_visitor.rb",
     "lib/treevisitor/visitors/callback_tree_node_visitor.rb",
     "lib/treevisitor/visitors/callback_tree_node_visitor2.rb",
     "lib/treevisitor/visitors/clone_tree_node_visitor.rb",
     "lib/treevisitor/visitors/depth_tree_node_visitor.rb",
     "lib/treevisitor/visitors/flat_print_tree_node_visitors.rb",
     "lib/treevisitor/visitors/print_dir_tree_visitor.rb",
     "lib/treevisitor/visitors/print_tree_node_visitor.rb",
     "test_data/gf_utility/kwartz_test_data/out.certified/dummy.txt",
     "test_data/gf_utility/kwartz_test_data/out/dummy.txt",
     "test_data/gf_utility/kwartz_test_data/source/test1.html",
     "test_data/gf_utility/kwartz_test_data/source/test1.plogic",
     "test_data/tree_visitor/test_data/.dir_with_dot/dummy.txt",
     "test_data/tree_visitor/test_data/dir.1/dir.1.2/file.1.2.1",
     "test_data/tree_visitor/test_data/dir.1/file.1.1",
     "test_data/tree_visitor/test_data/dir.2/file.2.1"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/gf/treevisitor}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{treevisitor}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Implementation of visitor design pattern}
  s.test_files = [
    "test/treevisitor/tc_dir_processor.rb",
     "test/treevisitor/cli/tc_cli_tree.rb",
     "test/treevisitor/tc_dir_tree_walker.rb",
     "test/treevisitor/tc_tree_node.rb",
     "test/treevisitor/tc_tree_node_visitor.rb",
     "test/treevisitor/tc_tree_node_dsl.rb",
     "test/treevisitor/test_helper.rb",
     "test/gf_utilities/tc_md5.rb",
     "test/gf_utilities/tc_kwartz.rb",
     "test/gf_utilities/tc_numeric.rb",
     "test/gf_utilities/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<abstract>, [">= 0"])
    else
      s.add_dependency(%q<abstract>, [">= 0"])
    end
  else
    s.add_dependency(%q<abstract>, [">= 0"])
  end
end
