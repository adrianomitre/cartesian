class CartesianIterator

  def initialize(foo, bar)
    @lists = []
    @tot_iter = 1
    product!(foo)
    product!(bar)
  end
  
  def dup
    Marshal.load(Marshal.dump(self))
  end
  
  def equal(other)
    self.instance_variables.each do |var_name|
      return false if self.instance_variable_get(var_name) != other.instance_variable_get(var_name)
    end
    true
  end
  alias == equal

  def product!(other)
    @lists << other.to_a.dup
    @tot_iter *= @lists[-1].size
    self
  end
  alias right_product! product!
  alias x! product!
  
  def left_product!(other)
    @lists.unshift other.to_a.dup
    @tot_iter *= @lists[-1].size
    self
  end
  
  def product(other)
    (result = self.dup).product!(other)
    result
  end
  alias right_product product
  alias x product

  def left_product(other)
    (result = self.dup).left_product!(other)
    result
  end

  def each
    return false if @tot_iter < 1

    elems = []
    for list in @lists
      elems << list.restart_and_raw_next
    end
    if RUBY_VERSION <= '1.9.1'; yield *elems.map {|x| x }; else; yield *elems; end

    last_list_index = @lists.size-1
    n = last_list_index
    loop do
      if elems[n] = @lists[n].raw_next
        if RUBY_VERSION <= '1.9.1'; yield *elems.map {|x| x }; else; yield *elems; end
        n = last_list_index
        next
      elsif n > 0
        elems[n] = @lists[n].restart_and_raw_next
        n -= 1
      else
        return true
      end
    end
  end

  include Enumerable

end

module Iterable
  def restart
    @next_index = -1
    true
  end

  def next
    restart unless @next_index
    raw_next
  end

  def raw_next
    self[@next_index += 1]
  end

  def restart_and_raw_next
    self[@next_index = 0]
  end
end

class Array
  include Iterable
end
