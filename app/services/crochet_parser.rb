class CrochetParser
  def initialize
    # @instructions_str = str.downcase
    @stitch_factory = StitchFactory.new
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

  # * Dc Inc * Repeat 2 times, sl st to join

  def parse_element(inst)
    instructions = []
    buffer = StringScanner.new(inst)

    until buffer.eos?
      current_instruction = buffer.scan_until(/#{Tokens::INSTRUCTION_DELIMITER}|$/)
      next unless current_instruction.present?
      current_instruction = clean_instruction(current_instruction)
      # * dc inc * repeat 2 times
      binding.pry
      if is_repeated_instruction(current_instruction)
        puts 'oops'
      elsif is_composite_stitch(current_instruction)
        composite_stitch = parse_composite_stitch(current_instruction)
        instructions << composite_stitch unless composite_stitch.nil?

      elsif is_basic_stitch(current_instruction)
        instructions << @stitch_factory.get_stitch(current_instruction)

      else # explicit unknown instruction
        instructions << @stitch_factory.get_stitch(current_instruction)
      end
    end
    instructions
  end

  def basic_stitch?(inst)
    basic_stitch_abbrevs.include? inst
  end

  def composite_stitch?(inst)
    inst[composite_stitch_regex].present?
  end

  def repeated_instruction?(_inst)
    false
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

  def clean_instruction(inst)
    inst.sub(Tokens::INSTRUCTION_DELIMITER, '').strip
  end
end

module Tokens
  START_REPEAT = '[*({[]'.freeze
  END_REPEAT = '[*)}]'.freeze
  INSTRUCTION_DELIMITER = ','.freeze
end

module Stitches
  BASIC = %w[
    SingleCrochet
    DoubleCrochet
    SlipStitch
  ].freeze

  COMPOSITE = %w[
    Increase
    Join
  ].freeze
end
