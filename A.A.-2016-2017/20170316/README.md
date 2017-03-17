# Lezione di giovedì 16 marzo 2017

## Argomenti

* revisione dei compiti per casa
* test della classe `Processo`
  * `ruby`
  * `csound`
* realizzazione della classe:
  * `Pulviscolo` (con primo esempio scritto in classe)

## Codice

* `pulviscolo.rb`:

```ruby
class Coordinata 
  
        attr_accessor :x,:y 
        def initialize(x=0.0,y=0.0) 
            @x=x
            @y=y
        end
        
end 

# classe Retta
# - inizio: è la Coordinata di inizio 
# - fine: è la Coordinata di fine

class Retta 
       
       attr_reader :inizio,:fine
       def initialize (i,f)
           @inizio=i
           @fine=f   
       end
       
       def coefficiente_angolare 
           (self.fine.y-self.inizio.y)/(self.fine.x-self.inizio.x)         
       end
     
       def offset
           self.inizio.y-self.inizio.x*self.coefficiente_angolare
       end   
       
       def y(x)
           self.coefficiente_angolare*x+self.offset
       end
end

class Evento
      
      attr_reader :at,:dur,:freq,:amp,:instr
      def initialize(at,freq,dur=0.1,amp=-18.0,instr=1)
        @at=at
        @freq=freq
        @dur=dur
        @amp=amp
        @instr=instr
      end 
      
      def to_csound 
        "i%02d %8.4f %8.4f %+6.2f %8.4f\n" % [self.instr,self.at,self.dur,self.amp,self.freq]     
      end 
end
  
# classe Processo:
# elabora un elemento pulviscolare
# argomenti:
# - at: action time del Processo
# - mt: mid time del Processo 
# - et: end time del Processo
# - sflo: frequenza iniziale della retta inferiore
# - sfhi: frequenza iniziale della retta superiore
# - mf: frequenza della retta finale
# - ne: numero degli eventi

class Processo 
       
       attr_reader :sotto,:sopra,:coda,:eventi,:num_eventi 
       def initialize (at,mt,et,sflo,sfhi,mf,ne=100) 
           @sotto=Retta.new(Coordinata.new(at,sflo),Coordinata.new(mt,mf)) 
           @sopra=Retta.new(Coordinata.new(at,sfhi),Coordinata.new(mt,mf))
           @coda=Retta.new(Coordinata.new(mt,mf),Coordinata.new(et,mf))
           @num_eventi=ne
           crea 
       end
       def to_csound
         risultato= "f1 0 4096 10 1\n" 
         self.eventi.each {|e| risultato += e.to_csound }
         risultato
       end 
private
       def quando
         range=self.coda.fine.x-self.sopra.inizio.x
         rand()*range+self.sopra.inizio.x   
       end  
       def freq(q)
         if q>self.sopra.fine.x
           ris=self.coda.y(q)
         else 
           range=self.sopra.y(q)-self.sotto.y(q)
           ris=rand()*range+self.sotto.y(q)
         end
         return ris
       end
       def crea 
         @eventi=[]
         1.upto(self.num_eventi) do
           |n|
           at=quando
           f=freq(at)
           @eventi << Evento.new(at,f) 
         end
       end         
end

class Pulviscolo 
    attr_reader :filename
       def initialize (f)
           @filename=f
       end
       def fai
         a=genera
         processi=crea(a)
         scrivi(processi)
       end   
private
       def genera
         ris=[]
         File.open(self.filename,"r") do
           |file|
           while (!file.eof?)
             riga=file.gets
             temp=riga.split.map{|n| n.to_f}
             ris << temp
           end
          end
          ris
       end
       #pulviscolo di Nicb
       #metro - :metronomo 
       #nr    - :numero di ripetizioni
       def crea(a)
         procs=[]
         a.each do
           |riga|
           (at,mt,et,sflo,sfhi,mf,ne,metro,nr)=riga
           delta=60.0/metro
           #brevettato
           1.upto(nr) do
             procs << Processo.new(at,mt,et,sflo,sfhi,mf,ne)
             at += delta 
             mt += delta
             et += delta
            #brevettato fino a qui
           end
         end
         procs
       end
       def scrivi(procs)
         procs.each { |p| puts p.to_csound }
       end  
end      
```

## Compiti per casa

* Realizzazione individuale di un *proprio* pulviscolo, personale e identitario,
  utilizzando il software realizzato, un proprio file di metadati ed
  (eventualmente) altro software scritto personalmente.
