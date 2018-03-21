$LOAD_PATH.unshift(__dir__) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(__dir__)

module InstructionTokens
  START_REPEAT = '[*({\[]'.freeze
  END_REPEAT = '[*)}\]]'.freeze
  INSTRUCTION_DELIMITER = ','.freeze
end
