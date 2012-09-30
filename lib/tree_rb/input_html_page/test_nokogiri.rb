require 'rubygems'
require 'nokogiri'
require 'pp'

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
    puts ch.methods
    puts "***"
    puts "node_type: #{ch.node_type}"
    puts "name #{ch.name}"
    pp ch
    recursive_search(ch)
  end
end

parent = value.search("//body").first
recursive_search(parent)
