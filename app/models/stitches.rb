$LOAD_PATH.unshift(__dir__) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(__dir__)

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
