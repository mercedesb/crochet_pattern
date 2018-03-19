class PatternController < ApplicationController
  def index
    instructions = '* Dc inc * 4 times, sl st to join'
    @row = Row.new(instructions)
  end
end
