# Lezione di venerdì 20 gennaio 2017

![whiteboard](./TR_I_20170120_1.jpg)

## Argomenti

* introduzione a `csound`:
  * descrizione del `header`
  * il concetto di *control rate*
  * primi programmi, compilati

`primo.orc` e `primo.sco`

```csound
sr=44100
nchnls=1
kr=441
ksmps=100

;(commento)
/*commento*/


         instr   1
aout     oscil   10000,1000,1		 
		 out     aout
		 endin   

f1 0 4096 10 1 

i1 1 0.33  
```

`secondo.orc` e `secondo.sco`

```csound
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
		
f1 0 4096 10 1 

i1 1    0.33 
i1 0.1  1
```

`terzo.orc` e `terzo.sco`

```csound
sr=44100
nchnls=1
kr=441
ksmps=100

;(commento)
/*commento*/


         instr   1
kinv     expon   10000,p3,0.001		 
aout     oscil   kinv,p4,1		 
		 out     aout
		 endin   
		
f1 0 4096 10 1 

i1 1    0.33  1200 
i1 0.1  1     1300
```

`quarto.sco`

```csound
f1 0 4096 10 1 

i1 0    0.5  523.2    ;do
i1 0.5  0.5  587.3    ;re
i1 1    0.5  659.2    ;mi
i1 1.5  0.5  698.4    ;fa 
i1 2    0.5  783.9    ;sol
i1 2.5  0.5  880      ;la
i1 3    0.5  987.7    ;si
i1 3.5  0.5  1046.5   ;do
```

## Compiti per casa

* realizzare una scala diatonica ascendente con suoni glissati *staccato* esponenzialmente di una seconda maggiore ascendente
* scegliere collettivamente e democraticamente un linguaggio di programmazione tra `python` e `ruby`
