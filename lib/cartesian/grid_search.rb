$:.unshift(File.join(File.dirname(__FILE__), '..'))

require 'cartesian'
require 'grid_search'

class CartesianIterator
  include GridSearch
end
  

