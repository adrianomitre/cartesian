require File.join(File.dirname(__FILE__), 'test_helper.rb')
require File.join(File.dirname(__FILE__), 'extensions.rb')

class TestExtensions < Test::Unit::TestCase
  def test_among?
    assert 1.among?([1,2,3])
    assert ! 7.among?([1,2,3])
    assert (3.0).among?([1,2,3])
  end
end
