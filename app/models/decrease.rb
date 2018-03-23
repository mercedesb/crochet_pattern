require "base_stitch"

# Decorator pattern
class Decrease < BaseStitch
  attr_reader :children

  def initialize(children = [])
    @children = children
  end

  def make
    "#{@children.map(&:make).join(' ')} #{self.class.abbrev}"
  end

  def self.abbrev
    "dec"
  end

  def count
    children_count = @children.sum(&:count)
    children_count - 1
  end
end
