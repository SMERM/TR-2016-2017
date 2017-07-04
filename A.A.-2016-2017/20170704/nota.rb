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
