#!/usr/bin/env ruby

$COMMON_HOME = File.expand_path( File.join( File.dirname( __FILE__), ".." ) )
$:.unshift( File.join($COMMON_HOME, "lib" ) )

require 'webrick'
include WEBrick

htdocs = File.join( $COMMON_HOME, "htdocs")

s = HTTPServer.new(
  :Port            => 2000,
  :DocumentRoot    => htdocs
)

## mount subdirectories
# s.mount("/ipr", HTTPServlet::FileHandler, "/proj/ipr/public_html")
# s.mount("/~gotoyuzo",
#         HTTPServlet::FileHandler, "/home/gotoyuzo/public_html",
#        true)  #<= allow to show directory index.

trap("INT"){ s.shutdown }
s.start
