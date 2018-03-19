class RepeatInstruction < BaseStitch
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

  def count
    @children.sum(&:count) * @repeat
  end
end