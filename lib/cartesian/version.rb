module Cartesian #:nodoc:

  # Unfortunately, as of now, the version data must be replicated in ../cartesian.rb,
  # due to a mix of newgem versions, each requiring a different one. Not DRY :P
  #
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 5
    TINY  = 3

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
  
end

