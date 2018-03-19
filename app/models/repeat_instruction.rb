class RepeatInstruction < Instruction
  attr_reader :repeat
  attr_reader :children

  def initialize(repeat, children = [])
    @repeat = repeat
    @children = children
  end

  def make
    instructions = []

    @repeat.times { |_i| instructions << @children.map(&:make).join(' ') }

    instructions.join(' ')
  end
end