# -*- coding: utf-8 -*-
module TreeRb

  class D3jsHelper

    def run(directory_tree_walker, dirname, template, output)
      visitor = DirectoryToHash2Visitor.new(dirname)
      root    = directory_tree_walker.run(visitor).root
      begin
        str_json = JSON.pretty_generate(root)
        str_json = "var data = " + str_json

        render = ErbRender.new(template, str_json)
        output.puts render.render
      rescue JSON::NestingError => e
        $stderr.puts "#{File.basename(__FILE__)}:#{__LINE__} #{e.to_s}"
      end
    end
  end
end # module
