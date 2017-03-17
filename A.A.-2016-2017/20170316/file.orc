sr=44100
nchnls=1
kr=4410

          instr   1
iamp      =ampdbfs(p4)
kinv      expon   iamp,p3,iamp/100		 
aout      oscil   kinv,p5,1
          out     aout
          endin 