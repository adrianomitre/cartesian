require File.join(File.dirname(__FILE__), 'test_helper.rb')
require File.join(File.dirname(__FILE__), 'extensions.rb')

require 'cartesian/grid_search'

class TestCartesian < Test::Unit::TestCase
  def test_argmin
    assert_equal 0, *[-1,0,1].argmin {|x| x**2 }
    assert_equal [0,0], ((-3..3)**2).argmin {|x,y| x**2+y**2 }
  end

  def test_argmax
    assert_equal 0, *[-2,-1,0].argmax {|x| x**3 }
    values = []
    -3.step(3, 0.25) {|val| values << val }
    x, y = (values**2).argmax {|x,y| x**2+y**2 }
    assert x.among?([-3,3])
    assert y.among?([-3,3])
  end

end
