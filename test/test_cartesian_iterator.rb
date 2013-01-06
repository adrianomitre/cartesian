require File.join(File.dirname(__FILE__), 'test_helper.rb')
require 'cartesian'

class TestCartesianIterator < Test::Unit::TestCase
  
  def test_equal
    assert_equal [1].x([2]), [1].x([2])
    assert_not_equal [1].x([2]), [1].x([3])
  end
    
  def test_dup
    c = [1,2].x([3,4])
    d = c.dup
    e = d.x([5,6])
    assert_not_equal(e, c)
    assert_equal(c, d)
  end

end
