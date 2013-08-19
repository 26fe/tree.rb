# -*- coding: utf-8 -*-
module TreeRb

  class DirCatOutput

    def run(directory_tree_walker, options)
      require 'tree_rb/output_dircat/entry'
      require 'tree_rb/output_dircat/dircat_visitor'

      unless options[:output]
        $stderr.puts 'need to specify the -o options'
      else
        filename = options[:output]
        visitor  = DirCatVisitor.new(filename)
        #start = Time.now
        #me    = self
        #bytes = 0
        directory_tree_walker.run(visitor)
        visitor.save_to
      end
    end

  end
end # module
