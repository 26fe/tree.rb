# -*- coding: utf-8 -*-
module TreeRb

  class SqliteOutput

    def run(directory_tree_walker, output, options)

      begin
        require 'sqlite3'
        require 'tree_rb/output_plugins/sqlite/sqlite_dir_tree_visitor'
      rescue LoadError
        $stderr.puts 'You must gem install sqlite3 to use this output format'
        exit(1)
      end

      unless options[:output]
        $stderr.puts 'need to specify the -o options'
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
