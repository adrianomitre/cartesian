class Object

  # Syntax sugar for "is this object among this array?"
  #
  #   1.among? [1,2,3] #=> true
  #   0.among? [4,5] #=> false
  #
  def among?(ary)
    ary.include? self
  end

end
