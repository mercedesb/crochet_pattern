require 'base_stitch'

class SlipStitch < BaseStitch
  def make
    self.class.abbrev
  end

  def self.abbrev
    'sl st'
  end

  def count
    1
  end
end
