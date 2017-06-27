# Lezione del 22 giugno 2017

## Argomenti

* Realizzazione in classe della definizione delle `classi`
  * `Nota`
  * `Melodia`
* Realizzazione di un meta-linguaggio per la descrizione delle melodie
* Implementazione del meta-linguaggio all'interno della classe `Melodia`

## File `nota_melodia_lezione.rb`

```ruby
class Nota
  attr_reader :at,:lgt,:vol,:ptch,:tmbr
  def initialize(at,lgt,vol,ptch,tmbr)
	  @at = at
	  @lgt = lgt
    @vol = vol
	  @ptch = ptch
    @tmbr = tmbr
  end
  
  def et 
    self.at + self.lgt
  end
  
  def to_csound
    "i%02d %8.4f %8.4f %+5.2f %8.4f" % [self.tmbr,self.at,self.lgt,self.vol,self.ptch]
  end

end

class Melodia < Array   #La classe Melodia è sottoclasse della classe Array ora andiamo a definire i vari tipi di melodie  
  
  alias_method :old_append,:<<
  
  #prima di ridefinire << il vecchio << lo chiamiamo anche "old_append"
  
  def << (n)
    raise ArgumentError unless n.is_a?(Nota)
    self.old_append n 
  end
  
#Eccezioni=Gestione degli errori. Questo metodo genera una eccezione: le eccezioni servono ad evitare che l'errore blocchi il processo il corso e ridare il controllo degli errori al chiamante. Le eccezioni alzano un flag che indica un errore, e lo passa a chi l'ha chiamato, che in base a questa flag potrà fare qualcosa.
#raise è una keyword di ruby
#ArgumentError è una classe
#raise(ArgumentError) mi definisce un errore: se non ci fosse unless a quel punto il programma si fermerebbe sempre  
#unless n.is_a?(Nota) --> il programma si ferma a meno che n non sia una nota 
  
  def to_csound
    self.each {|n| print n.to_csound}
  end
  
  def load (filename)
    t = 1   #tempo metronomico: se non gli dico altro il tempo è di 60
    at = 0.0
    File.open(filename,"r") do #File è una classe che ha come metodo open, r è per lettura
      |fh| 
      while (!fh.eof?)
        line = fh.gets
        (type,args) = line.split(/\s+/, 2)
        case type  
        when /^\s*tempo/ then t = (args).to_f/60.0 #se a inizio riga trovi spazi e la scritta "tempo"
        when /^\s*p/ then at = advance(t,at,args)
        when /^\s*n/ then at = add_note(t,at,args)
        end
      end
      
    end 
  end
 
  def convert_to_dur(t,value)
    (num,den) = value.split(/\//) #apri espressione regolare, escape, splitta, chiudi l'espressione
    dur = t * (num.to_f/(den.to_f/4))
  end
  
  BASE_DO = 8.175
  
  def convert_to_note(nota,oct)
    note = %W(do do\# re re\# mi fa fa\# sol sol\# la la\# si)
    index = note.index(nota)
    abs_index = index + (oct.to_f + 1) * 12 
    BASE_DO * (2.0 ** (abs_index / 12.0))
  end
  
  def convert_to_din(din)
    dins = {"ff"=>-6, "f"=>-12, "mf"=>-18, "mp"=>-24, "p"=>-30, "pp"=>-36}
    dins[din]
  end 
  
  def advance(t,at,value)
    dur = convert_to_dur(t,value)
    at + dur 
  end
  
  def add_note(t,at,args)
    (nota,oct,ritm,dina,agogica,strm) = args.split(/\s+/)
    f = convert_to_note(nota,oct)
    dur = convert_to_dur(t,ritm)
    din = convert_to_din(dina)
    self << Nota.new(at,dur,din,f,strm)
    at + dur
  end

end         























%q{
  MacBook-Pro-di-Sibladosi:Desktop sibladosi$ irb -I.
  irb(main):001:0> require "nota_melodia_lezione.rb"
  SyntaxError: /Users/sibladosi/Desktop/nota_melodia_lezione.rb:19: syntax error, unexpected keyword_end, expecting end-of-input
  	from /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/core_ext/kernel_require.rb:55:in `require'
  	from /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/core_ext/kernel_require.rb:55:in `require'
  	from (irb):1
  	from /usr/bin/irb:12:in `<main>'
  irb(main):002:0> require "nota_melodia_lezione.rb"
  => true
  irb(main):003:0> m=Melodia.new
  => []
  irb(main):004:0> m.is_a? Array
  => true
  irb(main):005:0> m.is_a? Melodia
  => true
  irb(main):006:0> m << 23
  ArgumentError: ArgumentError
  	from /Users/sibladosi/Desktop/nota_melodia_lezione.rb:24:in `<<'
  	from (irb):6
  	from /usr/bin/irb:12:in `<main>'
  irb(main):007:0> m << Nota.new(1,2,3,4,5)
  SystemStackError: stack level too deep
  	from /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/irb/workspace.rb:86
  Maybe IRB bug!}            

```

## File `esempio_melodia.mel`

```
tempo 62.5
p 3/8
n do# 5 3/16 ff ten 1
```
