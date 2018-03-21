$LOAD_PATH.unshift(__dir__) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(__dir__)

# Base Parser
class Parsers::BaseParser
  def parse
    raise NotImplementedError
  end

  def self.parsable?(_inst)
    raise NotImplementedError
  end

  protected

  def self.digit_regex
    /\d+/
  end
end
