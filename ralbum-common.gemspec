# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ralbum-common}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Giovanni"]
  s.date = %q{2009-05-20}
  s.description = %q{FIX (describe your package)}
  s.email = ["tokiro.oyama@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "README.txt", "TODO.txt"]
  s.files = ["History.txt", "README.txt", "TODO.txt", "lib/ralbum-common.rb", "lib/ralbum-common/abs_node.rb", "lib/ralbum-common/build_dir_tree_visitor.rb", "lib/ralbum-common/cli/cli_dir_tree.rb", "lib/ralbum-common/dir_processor.rb", "lib/ralbum-common/dir_tree_walker.rb", "lib/ralbum-common/kwartzhelper.rb", "lib/ralbum-common/leaf_node.rb", "lib/ralbum-common/md5.rb", "lib/ralbum-common/numeric.rb", "lib/ralbum-common/object_with_properties.rb", "lib/ralbum-common/object_with_validation.rb", "lib/ralbum-common/tree_node.rb", "lib/ralbum-common/tree_node_visitor.rb", "lib/ralbum-common/utility.rb", "test/ralbum-common/tc_dir_processor.rb", "test/ralbum-common/tc_dir_tree_processor.rb", "test/ralbum-common/tc_dir_tree_walker.rb", "test/ralbum-common/tc_md5.rb", "test/ralbum-common/tc_tree_node.rb", "test/ralbum-common/tc_tree_node_visitor.rb", "test/ralbum-common/test_data/dir.1/dir.1.2/file.1.2.1", "test/ralbum-common/test_data/dir.1/file.1.1", "test/ralbum-common/test_data/dir.2/file.2.1", "test/ralbum-common/ts_common.rb", "test/test_ralbum-common.rb"]
  s.has_rdoc = true
  s.homepage = %q{FIX (url)}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ralbum-common}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{FIX (describe your package)}
  s.test_files = ["test/test_ralbum-common.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.8.3"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.3"])
  end
end
