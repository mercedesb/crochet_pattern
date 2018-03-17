# is this a stitch, not really... what pattern works here?
class Join < Stitch
  def initialize(stitch)
    @stitch = stitch
  end

  def make
    "#{@stitch.make} to join"
  end

  def count
    @stitch.count - 1
  end
end