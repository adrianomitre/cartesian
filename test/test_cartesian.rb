require File.join(File.dirname(__FILE__), 'test_helper.rb')
require 'cartesian'

class TestCartesian < Test::Unit::TestCase
  
  def test_arrays
    foo = [1,2,3]
    bar = %w{a b c}
    expected = [[1, "a"], [1, "b"], [1, "c"], [2, "a"], [2, "b"],
                [2, "c"], [3, "a"], [3, "b"], [3, "c"]]
    assert(foo.x(bar).to_a == expected)
    assert(Cartesian.product(foo,bar) == expected)
  end

  def test_ranges
    foo = 1..3
    bar = 4..6
    expected = [[1, 4], [1, 5], [1, 6], [2, 4], [2, 5],
                [2, 6], [3, 4], [3, 5], [3, 6]]
    assert(foo.x(bar).to_a == expected)
    assert(Cartesian.product(foo,bar) == expected)
  end
  
  def test_product
    c = [1].x([2])
    c.x([3])
    assert_equal [1].x([2]), c
  end
  
  def test_left_product
    c = [1].right_product([2])
    d = [1].left_product([2])
    e = [2].left_product([1])
    assert_not_equal c, d
    assert_equal c, e
    c = [1].x([2]).right_product([3])
    d = [1].x([2]).left_product([3])
    e = [2].x([3]).left_product([1])
    assert_not_equal c, d
    assert_equal c, e
  end

  def test_mixed
    foo = 1..3
    bar = %w{a b c}
    expected = [[1, "a"], [1, "b"], [1, "c"], [2, "a"], [2, "b"],
                [2, "c"], [3, "a"], [3, "b"], [3, "c"]]
    assert(foo.x(bar).to_a == expected)
    assert(Cartesian.product(foo,bar) == expected) ##################
  end
  
  def test_power
    ary = [1,2,3]
    assert_raise(ArgumentError) { ary**(-1) }
    assert_equal [], ary**0
    assert_equal ary, ary**1
    expected = [[0, 0, 0], [0, 0, 1], [0, 1, 0],\
                [0, 1, 1], [1, 0, 0], [1, 0, 1],\
                [1, 1, 0], [1, 1, 1]]
    assert_equal expected, ([0,1]**3).to_a
  end
  
  def test_joined_cartesian
    assert_equal ["1A", "1B", "2A", "2B"], [1,2].joined_cartesian(%w<A B>)
  end

end
