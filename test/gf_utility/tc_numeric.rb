require File.join( File.dirname(__FILE__), "test_helper")

require 'gf_utility/numeric.rb'

class TCNumeric < Test::Unit::TestCase

  def test_simple
    assert_equal "10", 10.with_separator
    assert_equal "10.0", 10.0.with_separator
    assert_equal "1,000,000", 1000000.with_separator
  end

end
