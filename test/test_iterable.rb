require File.join(File.dirname(__FILE__), 'test_helper.rb')
require 'iterable'

class TestIterable < Test::Unit::TestCase
  def setup
    @foo = [1, 2].extend Iterable
    @bar = [nil, "a", :b].extend Iterable
    @baz = Array.new(rand(100)) {|n| n % 2 == 0 ? n : (rand >= 0.5 ? nil : false) }
    @baz.extend Iterable
  end

  def test_next
    [@foo, @bar, @baz].each do  |ary|
      ary.each do |item|
        assert_equal item, ary.next
      end
    end
  end

  def test_done
    [@foo, @bar, @baz].each do  |ary|
      ary.size.times do
        assert !ary.done?
        assert_nothing_raised { ary.next }
      end
      assert ary.done?
      assert_raise(RangeError) { ary.next }
    end
  end

  def test_restart
    [@foo, @bar, @baz].each do  |ary|
      assert_equal ary.first, ary.next
      rand(ary.size-1).times { ary.next }
      assert_equal ary.first, ary.restart.next
    end
  end

  def test_extending_objects_from_other_classes
    baz = 'baz'.extend Iterable
    baz.size.times do |n|
      assert_equal baz[n], baz.next
    end
    assert_raise(RangeError) { baz.next }
  end
end
