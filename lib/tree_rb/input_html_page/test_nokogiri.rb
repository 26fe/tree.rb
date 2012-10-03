require 'rubygems'
require 'nokogiri'
require 'pp'

require './dom_walker'
require '../../../lib/tree_rb/visitors/flat_print_tree_node_visitor'
require '../../../lib/tree_rb/visitors/print_tree_node_visitor'
include TreeRb

value = Nokogiri::HTML.parse(<<-HTML_END)
  "<html>
    <body>
      <p id='para-1'>A</p>
      <div class='block' id='X1'>
        <h1>Foo</h1>
        <p id='para-2'>B</p>
      </div>
      <p id='para-3'>C</p>
      <h2>Bar</h2>
      <p id='para-4'>D</p>
      <p id='para-5'>E</p>
      <div class='block' id='X2'>
        <p id='para-6'>F</p>
      </div>
    </body>
  </html>"
HTML_END


# pp value

def recursive_search(parent)
  parent.children.each do |ch|


    puts "---------------"
    # puts ch.methods
    puts "***"
    puts "name #{ch.name}"
    puts "node_type: #{ch.node_type}"

    case ch.node_type
      when Nokogiri::XML::Node::ELEMENT_NODE
        puts "element"
      when Nokogiri::XML::Node::TEXT_NODE
        puts "text"
      else
        put "unknow"
    end


    # pp ch
    recursive_search(ch)
  end
end

parent = value.search("//body").first
# recursive_search(parent)

dom_walker = DomWalker.new(parent)
dom_walker.run(FlatPrintTreeNodeVisitor.new)
dom_walker.run(PrintTreeNodeVisitor.new)


