ngranelli=100
inizio=1
fine=10

print "f1 0 4096 10 1\n"
1.upto(ngranelli) do
  
  at=rand()*9+1
  freq=rand()*1100+400
  dur=rand()*0.2+0.01
  
  print "i1 %08.4f %8.4f %11.6f\n" % [at,dur,freq]

end

