class PatternController < ApplicationController
  def index
    if (params[:instructions].present?)
      @row = Row.new(params[:instructions])
    end
    # instructions = '* Dc inc * 4 times, sl st to join'
    # @row = Row.new(instructions)
  end
end
