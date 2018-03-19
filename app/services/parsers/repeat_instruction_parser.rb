# Repeat Instruction Parser
class Parsers::RepeatInstructionParser < Parsers::BaseParser
  def initialize(instruction)
    @instruction = instruction.downcase.strip
  end

  def parse
    instructions = []
     # get capture group
    repeated_instructions = @instruction.match(self.class.repeated_regex)[1]
    repeat_times = @instruction[digit_regex]

    parser = ParserFactory.new.get_parser(repeated_instructions)
    instructions << parser.parse
    RepeatInstruction.new(repeat_times, instructions.flatten)
  end

  def self.parsable?(instruction)
    instruction.downcase.strip[repeated_regex].present?
  end

  def self.repeated_regex
    /#{InstructionTokens::START_REPEAT}(.+)#{InstructionTokens::END_REPEAT}/
  end

  private

  def digit_regex
    /\d+/
  end


end