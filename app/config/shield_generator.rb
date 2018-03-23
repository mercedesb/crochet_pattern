require "./app/config/generic_http_client"

class ShieldGenerator
  module Colors
    BRIGHT_GREEN = "brightgreen".freeze
    GREEN = "geen".freeze
    YELLOW_GREEN = "yellowgreen".freeze
    YELLOW = "yellow".freeze
    ORANGE = "orange".freeze
    RED = "red".freeze
    LIGHT_GRAY = "lightgray".freeze
    BLUE = "blue".freeze
  end

  module Styles
    PLASTIC = "plastic".freeze
    FLAT = "flat".freeze
    FLAT_SQUARE = "flat-square".freeze
    FOR_THE_BADGE = "for-the-badge".freeze
    SOCIAL = "social".freeze
  end

  def initialize(shield_client = GenericHttpClient.new)
    @shield_client = shield_client
  end

  def write_shield(subject, status, color = Colors::LIGHT_GRAY)
    url = "#{base_url}#{subject}-#{status}-#{color}.svg"
    response = @shield_client.get(url)
    File.open(shield_location(subject), "w") do |file|
      file.write response.body
    end
  end

  private

  def base_url
    "https://img.shields.io/badge/"
  end

  def shield_location(subject)
    "shields/#{subject}.svg"
  end
end

