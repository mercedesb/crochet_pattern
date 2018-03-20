# Basic Stitch Parser
#
class Parsers::BasicStitchParser < Parsers::BaseParser
  def initialize(instructions)
    @instructions = instructions.downcase.strip
    @stitch_factory = StitchFactory.new
  end

  def parse
    return unless self.class.parsable?(@instructions)

    stitch_to_parse = @instructions[self.class.basic_stitch_regex]
    basic_stitch = @stitch_factory.get_stitch(stitch_to_parse)
    repeat_times = @instructions[self.class.digit_regex].to_i

    if (repeat_times > 1)
      RepeatInstruction.new(repeat_times, [*basic_stitch])
    else
      basic_stitch
    end
  end

  def self.parsable?(inst)
    inst.downcase.strip[basic_stitch_regex].present?
  end

  private

  def self.basic_stitch_abbrevs
    @basic_stitches ||= Stitches::BASIC.map do |stitch|
      stitch.constantize.abbrev
    end
  end

  def self.basic_stitch_regex
    /#{basic_stitch_abbrevs.join("|")}/
  end
end
