# Basic Stitch Parser
#
class Parsers::BasicStitchParser < Parsers::BaseParser
  def initialize(instructions)
    @instructions = instructions.downcase.strip
    @stitch_factory = StitchFactory.new
  end

  def parse
    @stitch_factory.get_stitch(@instructions) if self.class.parsable?(@instructions)
  end

  def self.parsable?(inst)
    basic_stitch_abbrevs.include? inst.downcase.strip
  end

  private
  def self.basic_stitch_abbrevs
    @basic_stitches ||= Stitches::BASIC.map do |stitch|
      stitch.constantize.abbrev
    end
  end
end