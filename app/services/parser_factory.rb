class ParserFactory
  def get_parser(inst)
    if Parsers::RepeatInstructionParser.parsable?(inst)
      Parsers::RepeatInstructionParser.new(inst)
    elsif Parsers::CompositeStitchParser.parsable?(inst)
      Parsers::CompositeStitchParser.new(inst)
    elsif Parsers::BasicStitchParser.parsable?(inst)
      Parsers::BasicStitchParser.new(inst)
    else
      TestParser.new(inst)
    end
  end
end