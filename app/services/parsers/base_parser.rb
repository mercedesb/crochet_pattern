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
