require './app/config/shield_generator'
require 'simplecov'

class GhShieldsBuilder
  def initialize
    @generator = ShieldGenerator.new
  end

  def build_shields
    @generator.write_shield("coverage", coverage_percentage, coverage_color)
  end

  private

  def coverage_percentage
    SimpleCov.result.covered_percent.round(2)
  end

  def coverage_color
    case coverage_percentage
    when 95..100
      ShieldGenerator::Colors::BRIGHT_GREEN
    when 84..94
      ShieldGenerator::Colors::GREEN
    when 80..84
      ShieldGenerator::Colors::YELLOW_GREEN
    when 70..79
      ShieldGenerator::Colors::YELLOW
    when 60..69
      ShieldGenerator::Colors::ORANGE
    else
      ShieldGenerator::Colors::RED
    end
  end
end
