class Row < Instruction
  SLIP_STITCH_REGEX = /[ ]*(sl st)[ ]*/
  TO_JOIN_REGEX = /[ ]*(to join)[ ]*/

  INSTRUCTION_REPEAT_REGEX = /(\*.+\*.+?(?:(?!,).)+),/
  BETWEEN_REPEAT_REGEX = /[*{(](.+)[*})]/
  FALLBACK_REGEX = /(.+)/

  STITCH_INST_REGEX = /#{SLIP_STITCH_REGEX}|#{TO_JOIN_REGEX}|#{INSTRUCTION_REPEAT_REGEX}|#{BETWEEN_REPEAT_REGEX}|#{FALLBACK_REGEX}/

  attr_reader :stitches

  def initialize(instructions)
    @instructions = instructions
    @stitch_factory = StitchFactory.new
    @stitches = []
  end

  def make
    get_stitches
    row = ""
    @stitches.each do |stitch|
      row << stitch.make
    end

    row
  end

  def split_instructions(inst)
    inst.scan(STITCH_INST_REGEX).flatten.reject{ |s| s.nil? }
  end

  def get_stitches
    binding.pry
    stitch_instructions = split_instructions(@instructions)

    if stitch_instructions.length == 1
      @stitches << @stitch_factory.get_stitch(stitch_instructions[0])
    else
      stitch_instructions.each do |instruction|
        get_stitches(instruction)
      end
    end
  end
end