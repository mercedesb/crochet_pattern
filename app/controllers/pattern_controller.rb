class PatternController < ApplicationController
  def index
    @stitch_count = 0
    stitches = []

    6.times do |n|
      stitches << Increase.new(DoubleCrochet.new)
    end

    stitches << Join.new(SlipStitch.new)

    @row = ""
    stitches.each do |stitch|
      @row << stitch.make
      @row << " "
      @stitch_count += stitch.count
    end
  end
end
