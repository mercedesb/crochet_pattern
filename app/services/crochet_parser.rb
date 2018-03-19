# Parse string instructions into Stitches
class CrochetParser
  def initialize(instructions)
    @instructions_str = instructions.downcase
    @stitch_factory = StitchFactory.new
  end

  def parse
    parse_element(@instructions_str)
  end

  def parse_element(inst)
    instructions = []
    buffer = StringScanner.new(inst)

    until buffer.eos?
      current_instruction = buffer.scan_until(/#{Tokens::INSTRUCTION_DELIMITER}|$/)
      current_instruction = clean_instruction(current_instruction)

      instructions << if repeated_instruction?(current_instruction)
                        parse_repeated_instruction(current_instruction)
                      elsif composite_stitch?(current_instruction)
                        parse_composite_stitch(current_instruction)
                      elsif basic_stitch?(current_instruction)
                        parse_basic_stitch(current_instruction)
                      else # explicit unknown instruction
                        @stitch_factory.get_stitch(current_instruction)
                      end
    end
    instructions
  end

  def basic_stitch_abbrevs
    @basic_stitches ||= Stitches::BASIC.map do |stitch|
      stitch.constantize.abbrev
    end
  end

  def composite_stitch_abbrevs
    @composite_stitches ||= Stitches::COMPOSITE.map do |stitch|
      stitch.constantize.abbrev
    end
  end

  def composite_stitch_regex
    /#{composite_stitch_abbrevs.join("|")}/
  end

  def basic_stitch?(inst)
    basic_stitch_abbrevs.include? inst
  end

  def parse_basic_stitch(inst)
    @stitch_factory.get_stitch(inst)
  end

  def composite_stitch?(inst)
    inst[composite_stitch_regex].present?
  end

  def parse_composite_stitch(inst)
    composite_stitch = inst[composite_stitch_regex]
    if composite_stitch.present?
      composite_stitch_children = inst.scan(/(.+)#{composite_stitch_regex}/).flatten

      unless composite_stitch_children.empty?
        children = []
        composite_stitch_children.each { |child| children = parse_element(child) }
        parsed_stitch = @stitch_factory.get_stitch(composite_stitch, children)
      end
    end
    parsed_stitch
  end

  def repeated_instruction?(inst)
    inst[/#{Tokens::START_REPEAT}.+#{Tokens::END_REPEAT}/].present?
  end

  def parse_repeated_instruction(inst)
    # get capture group
    repeated = inst.match(/#{Tokens::START_REPEAT}(.+)#{Tokens::END_REPEAT}/)[1]
    times = inst[/\d+/]
    RepeatInstruction.new(times, parse_element(repeated))
  end

  def clean_instruction(inst)
    inst.sub(Tokens::INSTRUCTION_DELIMITER, '').strip
  end
end

module Tokens
  START_REPEAT = '[*({\[]'.freeze
  END_REPEAT = '[*)}\]]'.freeze
  INSTRUCTION_DELIMITER = ','.freeze
end
