require "net/http"

class GenericHttpClient
  def get(url)
    Net::HTTP.get_response(URI(url))
  end
end

puts GenericHttpClient.new.get("https://img.shields.io/badge/subject-status-blue.svg")