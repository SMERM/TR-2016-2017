sr=44100
nchnls=1
kr=441
ksmps=100

;(commento)
/*commento*/


         instr   1
kinv     expon   10000,p3,0.001		 
aout     oscil   kinv,1000,1		 
		 out     aout
		 endin   
		
