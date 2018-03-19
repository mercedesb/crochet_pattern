class BaseStitch < Instruction
  def self.abbrev
    raise NotImplementedError
  end
  def count
    raise NotImplementedError
  end
end