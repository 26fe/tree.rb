require File.join( File.dirname(__FILE__), "test_helper")

require 'gf_utility/md5.rb'

class TCMD5 < Test::Unit::TestCase

  TEST_FILE = File.join( $TREEVISITOR_HOME, "lib", "treevisitor.rb" )

  def test_simple_build
    file_name = File.join( TEST_FILE )
    MD5.file( file_name )
  end

end
