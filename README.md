tree.rb / tree visitor library
================================================

**tree.rb** is a 'clone' of tree unix command. It is based on tree visitor library.
Tree visitor is an implementation of visitor design pattern.

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
         |-- callback_tree_node_visitor.rb
         |-- callback_tree_node_visitor2.rb
         |-- clone_tree_node_visitor.rb
         |-- depth_tree_node_visitor.rb
         |-- flat_print_tree_node_visitors.rb
         |-- print_dir_tree_visitor.rb
         `-- print_tree_node_visitor.rb
</pre>

### Documentation

http://rubydoc.info/gems/treevisitor

Try tree.rb -h to get help on command line.
See examples directory to use treevisitor in your code

== INSTALL:

  sudo gem install treevisitor

### Contributions

Everybody is welcome to contribute to this project by commenting the source code, suggesting modifications or new ideas,
reporting bugs, writing some documentation and, of course, you're also welcome to contribute with patches as well!

### Rubies

This gem have been tested on [MRI][8] 1.9.2.

### Copyright

Copyright (c) 2009-2011 tokiro.oyama@gmail.com. See LICENSE for details.

[8]: http://www.ruby-lang.org/en/
