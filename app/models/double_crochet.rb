class DoubleCrochet < BaseStitch
  def make
    self.class.abbrev
  end

  def self.abbrev
    'dc'
  end

  def count
    1
 end
end
