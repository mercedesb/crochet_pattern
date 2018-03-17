# Decorator pattern
class Increase < Stitch
  def initialize(stitch)
    @stitch = stitch
  end

  def make
    "#{@stitch.make} inc"
  end

  def count
    @stitch.count + 1
  end
end