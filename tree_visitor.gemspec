# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tree_visitor}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["gf"]
  s.date = %q{2009-05-22}
  s.default_executable = %q{dirtree.rb}
  s.email = %q{giovanni.ferro@gmail.com}
  s.executables = ["dirtree.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".autotest",
     ".document",
     ".gitignore",
     "History.txt",
     "LICENSE",
     "Manifest.txt",
     "README.rdoc",
     "Rakefile",
     "TODO.rdoc",
     "VERSION",
     "bin/dirtree.rb",
     "lib/tree_visitor.rb",
     "lib/tree_visitor/abs_node.rb",
     "lib/tree_visitor/build_dir_tree_visitor.rb",
     "lib/tree_visitor/cli/cli_dir_tree.rb",
     "lib/tree_visitor/dir_processor.rb",
     "lib/tree_visitor/dir_tree_walker.rb",
     "lib/tree_visitor/leaf_node.rb",
     "lib/tree_visitor/md5.rb",
     "lib/tree_visitor/tree_node.rb",
     "lib/tree_visitor/tree_node_visitor.rb",
     "lib/tree_visitor/visitor/print_node_visitor2.rb",
     "nbproject/configs/dir_tree.properties",
     "nbproject/configs/permutazioni.properties",
     "nbproject/configs/tc_md5.properties",
     "nbproject/configs/test_wx_listctrl.properties",
     "nbproject/configs/tmp_queries.properties",
     "nbproject/configs/ts_common.properties",
     "nbproject/private/config.properties",
     "nbproject/private/configs/dir_tree.properties",
     "nbproject/private/configs/tmp_queries.properties",
     "nbproject/private/private.properties",
     "nbproject/private/private.xml",
     "nbproject/private/rake-d.txt",
     "nbproject/project.properties",
     "nbproject/project.xml",
     "test/tree_visitor/tc_dir_processor.rb",
     "test/tree_visitor/tc_dir_tree_walker.rb",
     "test/tree_visitor/tc_md5.rb",
     "test/tree_visitor/tc_tree_node.rb",
     "test/tree_visitor/tc_tree_node_visitor.rb",
     "test/tree_visitor/test_data/dir.1/dir.1.2/file.1.2.1",
     "test/tree_visitor/test_data/dir.1/file.1.1",
     "test/tree_visitor/test_data/dir.2/file.2.1",
     "test/ts_tree_visitor.rb",
     "tree_visitor.gemspec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/gf/tree_visitor}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/ts_tree_visitor.rb",
     "test/tree_visitor/tc_dir_processor.rb",
     "test/tree_visitor/tc_md5.rb",
     "test/tree_visitor/tc_dir_tree_walker.rb",
     "test/tree_visitor/tc_tree_node.rb",
     "test/tree_visitor/tc_tree_node_visitor.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
