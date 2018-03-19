class CrochetParser
  def initialize
    # @instructions_str = str.downcase
    @instructions = []
    @stitch_factory = StitchFactory.new
    @basic_stitches
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

  def parse
    until @buffer.eos?
      skip_spaces
      parse_element
    end
  end

  # Dc, sc, sl st to join
  # DoubleCrochet, SingleCrochet, Join(SlipStitch)
  #
  # sl st to join
  # dc inc

  def parse_element(inst)
    instructions = []
    buffer = StringScanner.new(inst)
    # binding.pry

    while !buffer.eos?
      current_instruction = buffer.scan_until(/,|$/)
      binding.pry
      if (current_instruction.present?)
        current_instruction = clean_instruction(current_instruction)

        composite_stitch = parse_composite_stitch(current_instruction)
        instructions << composite_stitch unless composite_stitch.nil?

        if basic_stitch_abbrevs.include? current_instruction
          instructions << @stitch_factory.get_stitch(current_instruction)
        # else
        #   instructions << parse_element(current_instruction)
        end
      end

    end
    instructions
  end

  def parse_composite_stitch(inst)
    composite_stitch = inst[composite_stitch_regex]
    if composite_stitch.present?
      composite_stitch_children = inst.scan(/(.+)#{composite_stitch_regex}/).flatten

      if composite_stitch_children.length > 0
        children = []
        composite_stitch_children.each { |child| children = parse_element(child) }
        binding.pry
        parsed_stitch = @stitch_factory.get_stitch(composite_stitch, children)
      end
    end
    parsed_stitch
  end

  def clean_instruction(inst)
    inst.sub(/,/, '').strip
  end

       # if (current_instruction.match())
        # @instructions << parse_element(current_instruction)
      # else
      # if buffer.check_until(START_REPEAT)
      # if buffer.peek(1).match(START_REPEAT)
      #   buffer.getch
      #   @instructions << find_content
      #   # look ahead to how many times to repeat
      # else
      #   @instructions << buffer.scan_until(" ")

  #fix this
  def skip_spaces
    @buffer.skip(/\s+/)
  end

  def find_content
    content = @buffer.scan_until END_REPEAT
    content.sub(END_REPEAT, "")
  end
end

module Tokens
  START_REPEAT = "[*({[]"
  END_REPEAT = "[*)}]"
  INSTRUCTION_DELIMITER = ","
end

module Stitches
  BASIC =  %w(
    SingleCrochet
    DoubleCrochet
    SlipStitch
  )

  COMPOSITE = %w(
    Increase
    Join
   )
end