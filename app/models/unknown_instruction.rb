class UnknownStitch < Instruction
  def initialize(instruction)
    @instruction = instruction
  end
  def make
    @instruction
  end
end