$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'cartesian_iterator'

# The Cartesian  module provide methods for the calculation
# of the cartesian producted between two enumerable objects.
#
# It can also be easily mixed in into any enumerable class,
# i.e. any class with Enumerable module mixed in.
# Notice that the names of the methods for mixin are different.
#
# Module:
#   Cartesian::product(foo, bar)
#
# Mixin:
#   foo.cartesian( bar )
#
# The module is automatically mixed in Array class.
#
# == Author
# Adriano MITRE <adriano.mitre@gmail.com>
#
# == Example
#
# as module
#   require 'cartesian'
#   foo = [1, 2]
#   bar = ["a", "b"]
#   Cartesian::product(foo, bar) #=> [[1, "a"], [1, "b"], [2, "a"], [2, "b"]]
# as mixin
#   require 'cartesian'
#   foo = [1, 2]
#   bar = ["a", "b"]
#   foo.cartesian(bar)  #=> [[1, "a"], [1, "b"], [2, "a"], [2, "b"]]
#
module Cartesian

  VERSION = '0.5.0'

  # Produces the cartesian product of self and other.
  # The result is an array of pairs (i.e. two-element arrays).
  #
  #   Cartesian::product( [1,2], %w(A B) ) #=> [[1, "A"], [1, "B"], [2, "A"], [2, "B"]]
  #
  # or, if mixed in into Array,
  #
  #   [1,2].cartesian %w(A B) #=> [[1, "A"], [1, "B"], [2, "A"], [2, "B"]]
  #
  def Cartesian.product(first, second)
    first.x(second).to_a
  end

  # Behaves as product, except for the elements are joined.
  #
  #   Cartesian::joined_cartesian( [1,2], %w(A B) ) #=> ["1A", "1B", "2A", "2B"]
  #
  # or, if mixed in into Array,
  #
  #   [1,2].joined_cartesian %w(A B) #=> ["1A", "1B", "2A", "2B"]
  #
  def Cartesian.joined_product(first, second)
    product(first, second).map {|pair| pair.join }
  end

  # Cartesian.joined_product for mixin.
  #
  def joined_cartesian(other)
    Cartesian.joined_product(self, other)
  end

  # Convenient way of iterating over the elements.
  # Preferable when the cartesian product array
  # is not needed, for the consumption of memory
  # is fixed and very small, in contrast with the
  # exponential memory requirements of the
  # conventional approach.
  #
  #   for row, col in (1..10).x(1..30)
  #     Matrix[row, col] = row**2 + col**3
  #   end
  #
  # Of course, calls can be chained as in
  #
  #   for x, y, z in (1..10).x(1..10).x(1..10)
  #     # ... do something ...
  #   end
  #
  #--
  #   for letter, number in %w{a b c}.x(1..3)
  #     ... do something ...
  #   end
  #++
  #
  # Beware that both +self+ and +other+ must implement
  # +to_a+, i.e., be convertible to array.
  #
  def x(other)
    case other
    when CartesianIterator
      other.left_product(self)
    else
      CartesianIterator.new(self, other)
    end
  end
  alias cartesian x
  alias right_product x
  
  def left_product(other)
    case other
    when CartesianIterator
      other.right_product(self)
    else
      CartesianIterator.new(other, self)
    end
  end

  # Concise way of iterating multi-dimensionally
  # over the same array or range.
  #
  # For instance,
  #
  #   for x,y,z in [0,1]**3
  #     puts [x, y, z].join(',')
  #   end
  #
  # produces the following output
  #
  #   0,0,0
  #   0,0,1
  #   0,1,0
  #   0,1,1
  #   1,0,0
  #   1,0,1
  #   1,1,0
  #   1,1,1
  #
  # It also works with Range objects.
  #
  def **(fixnum)
    if fixnum < 0
      raise ArgumentError, "negative power"
    elsif fixnum == 0
      return []
    elsif fixnum == 1
      return self
    else
      iter = CartesianIterator.new(self, self)
      (fixnum-2).times do
        iter.product!(self)
      end
      iter
    end
  end
  alias :power! :**
end

class Array
  include Cartesian
end

class Range
  include Cartesian
end
