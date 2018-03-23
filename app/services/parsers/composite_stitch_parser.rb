require "base_parser"
require "increase"
require "join"
require "stitches"

module Parsers
  # Composite Stitch Parser
  class CompositeStitchParser < Parsers::BaseParser
    def initialize(instructions)
      @instructions = instructions.downcase.strip
      @stitch_factory = StitchFactory.new
    end

    def parse
      return unless self.class.parsable?(@instructions)

      composite_stitch = @instructions[self.class.composite_stitch_regex]
      composite_stitch_children = @instructions.scan(/(.+)#{self.class.composite_stitch_regex}/).flatten

      unless composite_stitch_children.empty?
        children = []

        composite_stitch_children.each do |child|
          parser = ParserFactory.new.get_parser(child)
          children << parser.parse
        end
        parsed_stitch = @stitch_factory.get_stitch(composite_stitch, children.flatten)
      end
      parsed_stitch
    end

    def self.parsable?(inst)
      !inst.downcase.strip[composite_stitch_regex].nil?
    end

    def self.composite_stitch_abbrevs
      @composite_stitches ||= Stitches::COMPOSITE.map do |stitch|
        Module.const_get(stitch).abbrev
      end
    end

    def self.composite_stitch_regex
      /#{composite_stitch_abbrevs.join("|")}/
    end

    private_class_method :composite_stitch_abbrevs
  end
end
