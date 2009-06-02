require File.join( File.dirname(__FILE__), "test_helper")

require 'gf_utilities/md5.rb'

class TCMD5 < Test::Unit::TestCase

  TEST_FILE = File.join( $TREEVISITOR_HOME, "lib", "gf_utilities", "md5.rb" )

  def test_simple_md5
    file_name = File.join( TEST_FILE )
    assert_equal "8777d9d35da17496e21dcc8a4f9f8191", MD5.file( file_name ).to_s
  end

end
