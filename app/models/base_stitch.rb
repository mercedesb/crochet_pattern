$LOAD_PATH.unshift(__dir__) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(__dir__)

require "instruction"

class BaseStitch < Instruction
  def self.abbrev
    raise NotImplementedError
  end

  def count
    raise NotImplementedError
  end
end
