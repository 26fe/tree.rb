# -*- coding: utf-8 -*-

#
# std lib
#
require 'pathname'
require 'yaml'

#
# rubygems
#
require "rubygems"
require "abstract"

#
# treevisitor
#
module TreeVisitor
  def self.version
    cwd = Pathname(__FILE__).dirname.expand_path.to_s
    yaml = YAML.load_file(cwd + '/../VERSION.yml')
    major = (yaml['major'] || yaml[:major]).to_i
    minor = (yaml['minor'] || yaml[:minor]).to_i
    patch = (yaml['patch'] || yaml[:patch]).to_i
    "#{major}.#{minor}.#{patch}"
  end
end

require "treevisitor/abs_node"
require 'treevisitor/leaf_node'
require 'treevisitor/tree_node'
require 'treevisitor/basic_tree_node_visitor'
require 'treevisitor/tree_node_visitor'

require 'treevisitor/directory_walker'

#
# visitors
#
require 'treevisitor/visitors/block_tree_node_visitor'
require 'treevisitor/visitors/build_dir_tree_visitor'
require 'treevisitor/visitors/print_dir_tree_visitor'

require 'treevisitor/dir_processor'
