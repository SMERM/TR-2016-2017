require "nota_melodia_lezione"

class MelodiaFasce < Melodia #camel casing
  N_NOTE=10
  def variate() #variate crea 10 note che stanno tutte intorno alla nota presa
    temp = []
    self.each do
      |n|
      1.upto(N_NOTE) do
        delta = rand()* 0.4 + 0.8
        nn = Nota.new(n.at,n.lgt,n.vol-20.5,n.ptch*delta,n.tmbr)
        temp << nn
      end
    end
    self.concat temp
  end
end
