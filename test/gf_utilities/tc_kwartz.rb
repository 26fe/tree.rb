require File.join( File.dirname(__FILE__), "test_helper")

require 'fileutils'

class TCKwartz < Test::Unit::TestCase

  KWARTZ_TEST_DATA = File.join( $TREEVISITOR_HOME, "test_data", "gf_utility", "kwartz_test_data" )

  def test_simple

    begin
      require 'kwartz'
    rescue LoadError
      puts "WARNING kwartz_helper test not runned because kwartz is not present"
      return
    end

    require 'gf_utility/kwartzhelper'
    template_dir     = File.join( KWARTZ_TEST_DATA, "source" )
    template_out     = File.join( KWARTZ_TEST_DATA, "out" )
    kwartz_compile( template_dir, nil, template_out )

    out_filename = File.join( KWARTZ_TEST_DATA, "out", "test1.rb" )
    assert File.exists?(out_filename)
    FileUtils.rm out_filename
  end

end
