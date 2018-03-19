# Repeat Instruction Parser
class Parsers::RepeatInstructionParser < Parsers::BaseParser
  def initialize(instructions)
    @instructions = instructions.downcase.strip
  end

  def parse
    return unless self.class.parsable?(@instructions)

     # get capture group
    repeated_instructions = @instructions.match(self.class.repeated_regex)[1]
    repeat_times = @instructions[digit_regex].to_i

    parser = ParserFactory.new.get_parser(repeated_instructions)
    RepeatInstruction.new(repeat_times, [*parser.parse].flatten)
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