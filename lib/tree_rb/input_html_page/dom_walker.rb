# -*- coding: utf-8 -*-
module TreeRb

  class DomWalker
    def initialize(node)
      @node = node
    end

    def run(visitor)
      @visitor = visitor
      process_node(@node)
    end


    #
    # recurse on nodes
    #
    def process_node(node, level=1)
      entries = node.children
      @visitor.enter_node(node)
      entries.each do |entry|
        unless is_leaf?(entry)
          process_node(entry, level+1)
        else
          @visitor.visit_leaf(entry)
        end
      end
      @visitor.exit_node(node)
    end

    def is_leaf?(node)
      node.node_type == Nokogiri::XML::Node::TEXT_NODE
    end

  end # class
end # module
