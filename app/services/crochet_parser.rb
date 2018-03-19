class CrochetParser
  def initialize(str)
    @instructions_str = str
    @instructions = []
    @stitch_factory = StitchFactory.new
  end

  def parse
    until @buffer.eos?
      skip_spaces
      parse_element
    end
  end

  # Dc, sc, sl st to join
  # DoubleCrochet, SingleCrochet, Join(SlipStitch)

  def parse_element
    buffer = StringScanner.new(str)

    while !buffer.eos?
      current_instruction = buffer.check_until(/[,]?$/)
      if (current_instruction.present?)

        @instructions << @stitch_factory.get_stitch(current_instruction.sub(/,/), '')
      # else
      # if buffer.check_until(START_REPEAT)
      # if buffer.peek(1).match(START_REPEAT)
      #   buffer.getch
      #   @instructions << find_content
      #   # look ahead to how many times to repeat
      # else
      #   @instructions << buffer.scan_until(" ")
      end
    end
  end

  #fix this
  def skip_spaces
    @buffer.skip(/\s+/)
  end

  def find_content
    content = @buffer.scan_until END_REPEAT
    content.sub(END_REPEAT, "")
  end
end

# module Tokens
#   START_REPEAT = /[*({[]/
#   END_REPEAT = /[*)}]/
#   INSTRUCTION_DELIMITER = /,/
# end

module Stitches

end