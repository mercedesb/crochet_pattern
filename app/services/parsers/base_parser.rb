# Base Parser
class Parsers::BaseParser
  def parse
    raise NotImplementedError
  end

  def parsable?(inst)
    raise NotImplementedError
  end
end