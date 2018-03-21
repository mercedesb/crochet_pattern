$LOAD_PATH.unshift(__dir__) unless
    $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(__dir__)

require 'single_crochet'

puts SingleCrochet.abbrev