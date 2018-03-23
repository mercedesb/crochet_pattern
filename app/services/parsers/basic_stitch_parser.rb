require "base_parser"
require "single_crochet"
require "double_crochet"
require "slip_stitch"
require "stitch_factory"

module Parsers
  # Basic Stitch Parser
  class BasicStitchParser < Parsers::BaseParser
    def initialize(instructions)
      @instructions = instructions.downcase.strip
      @stitch_factory = StitchFactory.new
    end

    def parse
      return unless self.class.parsable?(@instructions)

      stitch_to_parse = @instructions[self.class.basic_stitch_regex]
      basic_stitch = @stitch_factory.get_stitch(stitch_to_parse)
      repeat_times = @instructions[self.class.digit_regex].to_i

      if repeat_times > 1
        RepeatInstruction.new(repeat_times, [*basic_stitch])
      else
        basic_stitch
      end
    end

    def self.parsable?(inst)
      !inst.downcase.strip[basic_stitch_regex].nil?
    end

    private

    def self.basic_stitch_abbrevs
      @basic_stitches ||= Stitches::BASIC.map do |stitch|
        Module.const_get(stitch).abbrev
      end
    end

    def self.basic_stitch_regex
      /#{basic_stitch_abbrevs.join("|")}/
    end
  end
end
