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
      current_instruction = ""
      skip_spaces

      if /#{InstructionTokens::START_REPEAT}/ =~ @buffer.peek(1)
        current_instruction += @buffer.getch
        current_instruction += @buffer.scan_until(/#{InstructionTokens::END_REPEAT}|$/)
        current_instruction += @buffer.scan_until(/#{InstructionTokens::INSTRUCTION_DELIMITER}|$/)
      else
        current_instruction = @buffer.scan_until(/#{InstructionTokens::INSTRUCTION_DELIMITER}|$/)
      end

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

  def skip_spaces
    @buffer.skip(/\s+/)
  end

  def clean_instruction(inst)
    inst.sub(/#{InstructionTokens::INSTRUCTION_DELIMITER}$/, '').strip
  end
end
