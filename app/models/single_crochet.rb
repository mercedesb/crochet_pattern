class SingleCrochet < Stitch
  def make
    self.class.abbrev
  end

  def self.abbrev
    "sc"
  end

  def count
    1
  end
end