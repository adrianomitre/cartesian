# encoding: UTF-8

# Code by Brian Schröäer
# source: http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/151857
#
def cartprod(base, *others)
  return base.map { |a| [a] } if others.empty?
  others = cartprod(*others)
  base.inject([]) { | r, a | others.inject(r) { | r, b | r << ([a,*b]) } }
end
