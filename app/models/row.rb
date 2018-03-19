class Row < Instruction
  def initialize(instructions)
    @instructions = instructions
    @parser_factory = ParserFactory.new
  end

  def make
    @stitches = get_stitches
    @stitches.map(&:make).join(' ')
  end

  def get_stitches
    parser = @parser_factory.get_row_parser(@instructions)
    [*parser.parse]
  end
end