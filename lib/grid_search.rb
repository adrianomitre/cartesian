module GridSearch

  # Finds the argument which maximizes the function given in the block trhu grid-search maximization.
  #   [-1,0,1,2].argmax {|x| x**2 } #=> 2
  #
  def argmax(&block)
    argbest(:>, &block)
  end
  
  # Finds the argument which minimizes the function given in the block trhu grid-search minimization.
  #   [-1,0,1,2].argmin {|x| x**2 } #=> 0
  #
  def argmin(&block)
    argbest(:<, &block)
  end

  private
  
  def argbest(cmp)
    best_arg, best_val = nil, nil
    self.each do |*curr_arg|
      curr_val = yield(*curr_arg)
      if best_val.nil? || curr_val.send(cmp, best_val)
        best_val = curr_val
        best_arg = curr_arg
      end
    end
    best_arg
  end

end

module Enumerable
  include GridSearch
end

class Array
  include GridSearch
end

