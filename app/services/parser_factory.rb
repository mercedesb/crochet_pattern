require "repeat_instruction_parser"
require "composite_stitch_parser"
require "basic_stitch_parser"
require "instruction_parser"

class ParserFactory
  def get_parser(inst)
    if Parsers::RepeatInstructionParser.parsable?(inst)
      Parsers::RepeatInstructionParser.new(inst)
    elsif Parsers::CompositeStitchParser.parsable?(inst)
      Parsers::CompositeStitchParser.new(inst)
    elsif Parsers::BasicStitchParser.parsable?(inst)
      Parsers::BasicStitchParser.new(inst)
      # else
      #   Parsers::InstructionParser.new(inst)
    end
  end

  def get_row_parser(inst)
    Parsers::InstructionParser.new(inst)
  end
end
