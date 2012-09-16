# -*- coding: utf-8 -*-
module TreeRb

  class ErbRender
    include ERB::Util
    attr_accessor :json_str

    def initialize(template_name, json_str)
      @template_name = template_name
      @json_str     = json_str
    end

    def render()
      template_file_name = File.join(File.dirname(__FILE__), "templates", @template_name)
      template = File.read(template_file_name)
      ERB.new(template).result(binding)
    end

  end

end # end module
