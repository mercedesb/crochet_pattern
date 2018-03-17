class PatternController < ApplicationController
  def index
    @stitch_count = 0
    stitches = []

    factory = StitchFactory.new

    6.times do |n|
      stitches << factory.get_stitch('dc')
      stitches << factory.get_stitch('inc')
    end

    stitches << factory.get_stitch('sl st')
    stitches << factory.get_stitch('to join')

    @row = ""
    stitches.each do |stitch|
      @row << stitch.make
      @row << " "
      @stitch_count += stitch.respond_to?('count') ? stitch.count : 0
    end
  end
end
