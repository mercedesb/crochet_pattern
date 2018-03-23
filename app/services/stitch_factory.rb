require "double_crochet"
require "single_crochet"
require "slip_stitch"
require "increase"
require "join"
require "unknown_instruction"

class StitchFactory
  def get_stitch(instruction, children = [])
    case instruction
    when DoubleCrochet.abbrev
      DoubleCrochet.new
    when SingleCrochet.abbrev
      SingleCrochet.new
    when SlipStitch.abbrev
      SlipStitch.new
    when Increase.abbrev
      Increase.new(children)
    when Join.abbrev
      Join.new(children)
    else
      UnknownInstruction.new(instruction)
    end
  end
end
