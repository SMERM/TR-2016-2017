sr=44100
ksmps=100
nchnls=1
0dbfs=1

instr 1,2

iamp = ampdb (p4)
ifreq  = p5
idur = p3
aout oscil iamp,ifreq,p1
aout linen aout,0.01,idur,0.01
out aout

endin
