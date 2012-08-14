tree.rb / tree visitor library
================================================

**tree.rb** is a 'clone' of tree unix command. 
The gem contains also a library to build tree with a dsl (domain specific language), and 
an implementation of visitor design pattern.

## Usage as command line

To use the command line tool tree.rb execute into command line tree.rb --help
Try tree.rb -h to get help on command line.

<pre>
$ tree.rb --help
Usage: tree.rb [options] [directory]
list contents of directories in a tree-like format
this is a almost :-) a clone of tree unix command written in ruby
Code https://github.com/tokiro/treevisitor. Feedback to tokiro.oyama@gmail.com

options: 
    -h, --help                       Show this message
        --version                    Show the version
    -a                               All file are listed
    -d                               List directories only
    -v, --[no-]verbose               Run verbosely
    -q, --quiet                      quiet mode as --no-verbose
    -f, --format ALGO                select an algo
                                       (b,v,j,y,build-dir,print-dir,json,yaml)
</pre>

To print the tree of a directory execute tree.rb with the name of the directory. 
For example:

<pre>
 $ tree.rb lib

  lib
 |-- tree_visitor.rb
 |-- treevisitor.rb
 |-- treevisitor_cli.rb
 `-- treevisitor
     |-- abs_node.rb
     |-- dir_processor.rb
     |-- dir_tree_walker.rb
     |-- leaf_node.rb
     |-- tree_node.rb
     |-- tree_node_visitor.rb
     |-- cli
     |   `-- cli_tree.rb
     `-- visitors
         |-- block_tree_node_visitor.rb
         |-- build_dir_tree_visitor.rb
         |-- callback_tree_node_visitor2.rb
         |-- clone_tree_node_visitor.rb
         |-- depth_tree_node_visitor.rb
         |-- flat_print_tree_node_visitors.rb
         |-- print_dir_tree_visitor.rb
         `-- print_tree_node_visitor.rb
</pre>

The **tree.rb** can generate json structure suitable to be visualized with [protovis][1] javascript library.
See the examples directory.

<pre>
$ ruby bin/tree.rb --format json lib

{
  "lib": {
    "tree_visitor.rb": 45,
    "treevisitor": {
      "abs_node.rb": 2858,
      "basic_tree_node_visitor.rb": 578,
      "cli": {
        "cli_tree.rb": 2929
      },
      "directory_walker.rb": 5049,
      "leaf_node.rb": 526,
      "tree_node.rb": 5665,
      "tree_node_visitor.rb": 1263,
      "util": {
        "dir_processor.rb": 928
      },
      "visitors": {
        "block_tree_node_visitor.rb": 386,
        "build_dir_tree_visitor.rb": 1167,
        "callback_tree_node_visitor2.rb": 1652,
        "clone_tree_node_visitor.rb": 837,
        "depth_tree_node_visitor.rb": 427,
        "directory_to_hash_visitor.rb": 639,
        "flat_print_tree_node_visitors.rb": 341,
        "print_dir_tree_visitor.rb": 387,
        "print_tree_node_visitor.rb": 707
      }
    },
    "treevisitor.rb": 976,
    "treevisitor_cli.rb": 87
  }
</pre>

The json structure can be transformed into image:
<img src='https://github.com/tokiro/tree.rb/raw/master/examples/protovis/treevisitor.png'/>

## Usage as library
See examples directory to use treevisitor in your code.

DSL to build tree:
<pre>
   tree = TreeNode.create do
     node "root" do
       leaf "l1"
       node "sub" do
         leaf "l3"
       end
       node "wo leaves"
     end
</pre>

## Documentation

http://rubydoc.info/gems/tree.rb


## Installation

To use the command line tool tree.rb, it is enough to install the gem:

  [sudo] gem install tree.rb

To use into your project, add this line to your application's Gemfile:

    gem 'tree.rb'

And then execute:

    $ bundle

## Contributing

Everybody is welcome to contribute to this project by commenting the source code, suggesting modifications or new ideas,
reporting bugs, writing some documentation and, of course, you're also welcome to contribute with patches as well!

To contribute:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Rubies

This gem have been tested on [MRI][8] 1.9.3

### Copyright

Copyright (c) 2009-2012 tokiro.oyama@gmail.com. See LICENSE for details.

[1]: http://vis.stanford.edu/protovis/
[8]: http://www.ruby-lang.org/en/

