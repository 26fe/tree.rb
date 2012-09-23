# -*- coding: utf-8 -*-
begin
  require 'sqlite3'
  require 'tree_rb/output_sqlite/sqlite_dir_tree_visitor'
rescue LoadError
  $stderr.puts 'You must gem install sqlite3 to use this output format'
end

module TreeRb

  class SqliteHelper

    def run(directory_tree_walker, output, options)
      unless options[:output]
        $stderr.puts "need to specify the -o options"
      else
        output.close
        filename = options[:output]
        visitor  = SqliteDirTreeVisitor.new(filename)
        #start = Time.now
        #me    = self
        #bytes = 0
        directory_tree_walker.run(visitor)
      end

    end

  end
end # module
