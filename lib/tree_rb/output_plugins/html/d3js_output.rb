# -*- coding: utf-8 -*-

module TreeRb

  class D3jsOutput

    def run(directory_tree_walker, dirname, template, output)
      require 'tree_rb/output_plugins/html/directory_to_hash2_visitor'
      require 'tree_rb/output_plugins/html/erb_render'

      visitor = DirectoryToHash2Visitor.new(dirname)
      root    = directory_tree_walker.run(visitor).root
      begin
        str_json = JSON.pretty_generate(root)
        str_json = 'var data = ' + str_json

        if template
          render = ErbRender.new(template, str_json)
          output.puts render.render
        else
          output.puts str_json
        end

      rescue JSON::NestingError => e
        $stderr.puts "#{File.basename(__FILE__)}:#{__LINE__} #{e.to_s}"
      end
    end
  end
end # module
