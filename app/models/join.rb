# is this a stitch, not really... what pattern works here?
class Join < Stitch
  def initialize(children = [])
    @children = children
  end

  def make
    "#{@children.map(&:make).join(' ')} #{self.class.abbrev}"
  end

  def self.abbrev
    "to join"
  end

  def count
    children_count = @children.sum(&:count)
    children_count - 1
  end
end