require 'cartesian'
require 'benchmark'

MULTIPLIER = 3
letras = ("a"*MULTIPLIER.."z"*MULTIPLIER).to_a
numeros = (0..10**1).to_a

Benchmark.bmbm do |x|
  letras_numeros = nil
  x.report("product") { letras_numeros = Cartesian.product(letras, numeros) }
  x.report("product 2") { for x,y in letras_numeros; end }

  x.report(".x") { letras_numeros = letras.x(numeros) }
  x.report(".x 2") { for x,y in letras_numeros; end }
end

#~ x.report("productZip") { Cartesian.productZip(letras, numeros) }

  #~ def Cartesian.productZip(first, second)
    #~ result = []
    #~ first.each do |a|
      #~ aaa = Array.new(second.size) { a }
      #~ result += aaa.zip(second)
    #~ end
    #~ result
  #~ end
