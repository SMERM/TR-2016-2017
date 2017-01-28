# Lezione di giovedì 26 gennaio 2017

![whiteboard](./TR_I_20170126_1.jpg)
![whiteboard](./TR_I_20170126_2.jpg)

## Argomenti

* revisione dei compiti per casa
* sommario dei linguaggi di programmazione:
  * linguaggi compilati
  * linguaggi interpretati
* scelta del linguaggio:
  * `python` o `ruby`? `ruby`
* realizzazione di una fascia di pulviscolo sonoro

`polvere.rb`:

```ruby
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
```

`polvere.orc`:

```csound
sr       =              44100
nchnls   =              1
kr       =              441
ksmps    =              100


                 
         instr  1

a1       oscil          1000,p4,1
         out            a1  
             
         endin
         
```


## Compiti per casa

* realizzazione di una fascia ascendente di pulviscolo sonoro
