class CrochetParser
  def initialize(str)
    @buffer = StringScanner.new(str)
    @instructions = []
    parse
  end

  def parse
    until @buffer.eos?
      skip_spaces
      parse_element
    end
  end

  def parse_element
    if @buffer.peek(1).match(START_REPEAT)
      @buffer.getch
      @instructions << find_content
      # look ahead to how many times to repeat
    else
      @instructions << @
    end
  end

  def skip_spaces
    @buffer.skip(/\s+/)
  end

  def find_content
    content = @buffer.scan_until END_REPEAT
    content.sub(END_REPEAT, "")
  end
end

module Tokens
  START_REPEAT = /[*({[]/
  END_REPEAT = /[*)}]/
  REPEAT_NUMBER_DELIMITER = /,/
end