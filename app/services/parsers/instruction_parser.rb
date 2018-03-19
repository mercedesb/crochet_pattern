# General Instruction Parser
class Parsers::InstructionParser < Parsers::BaseParser
  def initialize(instructions)
    @instructions_str = instructions.downcase.strip
    @stitch_factory = StitchFactory.new
    @buffer = StringScanner.new(@instructions_str)
  end

  def parse
    instructions = []

    until @buffer.eos?
      current_instruction = @buffer.scan_until(/#{InstructionTokens::INSTRUCTION_DELIMITER}|$/)
      current_instruction = clean_instruction(current_instruction)
      parser = ParserFactory.new.get_parser(current_instruction)
      instructions << if parser.nil?
                        @stitch_factory.get_stitch(current_instruction)
                      else
                        parser.parse
                      end
    end
    instructions
  end

  def parsable?(_inst)
    true
  end

  private

  def clean_instruction(inst)
    inst.sub(InstructionTokens::INSTRUCTION_DELIMITER, '').strip
  end
end