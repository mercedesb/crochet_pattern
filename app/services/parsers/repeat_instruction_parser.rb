# Repeat Instruction Parser
class Parsers::RepeatInstructionParser < Parsers::BaseParser
  def initialize(instructions)
    @instructions = instructions.downcase.strip
  end

  def parse
    return unless self.class.parsable?(@instructions)

    regex_match_data = @instructions.match(self.class.repeated_regex)
    repeated_instructions = regex_match_data[1]
    repeat_times = regex_match_data[2].to_i

    parser = ParserFactory.new.get_parser(repeated_instructions)
    RepeatInstruction.new(repeat_times, [*parser.parse].flatten)
  end

  def self.parsable?(instruction)
    match_index = repeated_regex =~ instruction.downcase.strip
    match_index.present?
  end

  def self.repeated_regex
    /#{InstructionTokens::START_REPEAT}(.+)#{InstructionTokens::END_REPEAT}.+(#{digit_regex}).*$/
  end
end
